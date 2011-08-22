class ChartController < ApplicationController
  before_filter :find_active_users
  before_filter :reject_losers

  def index
    @series = @users.map do |user|
      data = user.pushup_histories.map{|pushup| [pushup.created_at, pushup.count.to_i * pushup.multiplier]}
      { :name => user.handle, :data => data, :multiplier => user.multiplier }
    end
  end

  def sum
    handles = @users.map(&:handle)
    start_date = PushupHistory.first(:order => 'created_at').created_at.to_date
    end_date = PushupHistory.first(:order => 'created_at DESC').created_at.to_date
    dates = Hash[(start_date..end_date).map{|d|[d, nil]}]
    data = Hash[handles.zip(handles.length.times.map{|x| dates.clone })]
    PushupHistory.find(:all, :include => [:user], :order => 'created_at').map do |record|
      date = record.created_at.to_date
      if data[record.user.handle]
        data[record.user.handle][date] = record.count * record.multiplier
      end
    end
    Rails.logger.warn data.first.inspect
    @categories = data.first[1].keys.map{|d|d.strftime('%m/%d')}
    @series = data.map do |k,v|
      Rails.logger.warn v.inspect
      values = v.values
      values.each_with_index do |value, index|
        values[index] = index.zero? ? 0 : values[index] = values[index - 1] if value.nil?
      end
      { :name => k, :data => values }
    end
  end

  def punch
    data = []
    #TODO: memcache this in hourly buckets
    days = 7.times.map{ 24.times.map{0} }
    PushupHistory.all.each do |record|
      days[record.created_at.wday][record.created_at.hour] += record.diff
    end
    data = days.flatten
    data += 24.times.map{0}
    @chart_url = [
      "https://chart.googleapis.com/chart?chs=800x300&chds=-1,24,-1,7,0,#{data.max}&chf=bg,s,efefef&chd=t:",
      7.times.map{(0..23).to_a.join(',')}.join(','),
      '|',
      7.times.map{|i|24.times.map{i}.join(',')}.join(','),
      '|',
      data.join(','),
      "&chxt=x,y&chm=o,333333,1,1.0,25.0&chxl=0:||12am|1|2|3|4|5|6|7|8|9|10|11|12pm|1|2|3|4|5|6|7|8|9|10|11||1:||Sun|Mon|Tue|Wed|Thr|Fri|Sat|&cht=s"
    ].join('')
  end
private
  def find_user
    if current_user.admin?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def reject_losers
    @users.reject!{|u|u.pushup_set_count.zero?}
  end
end
