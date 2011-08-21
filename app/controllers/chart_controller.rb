class ChartController < ApplicationController
  before_filter :find_active_users

  def index
    @series = @users.map do |user|
      data = user.pushup_histories.map{|pushup| [pushup.created_at, pushup.count.to_i * 20]}
      {
        :name => user.handle,
        :data => data
      }
    end
  end

  def sum
    #TODO memcached?
    times = {}
    @users.each do |user|
      previous_count = 0
      user.pushup_histories.sort_by(&:created_at).each do |record|
        times[record.created_at] ||= 0
        dates[date] += (record.count - previous_count)
        previous_count = record.count
      end
    end
    @series =
      [
        {
          :name => "Sum",
          :data => dates.to_a
        }
      ]
    render :index
  end

private
  def find_active_users
    @users = User.active.sort_by{|user| -user.pushup_set_count }
  end

  def find_user
    if current_user.admin?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
end
