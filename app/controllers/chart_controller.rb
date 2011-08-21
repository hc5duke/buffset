class ChartController < ApplicationController
  before_filter :find_active_users

  def index
    @series = @users.map do |user|
      data = user.pushup_histories.map{|pushup| [pushup.created_at, pushup.count.to_i * 20]}
      { :name => user.handle, :data => data }
    end
  end

  def sum
    count = 0
    data = PushupHistory.find(:all, :order => 'created_at').map do |record|
      count += record.diff
      [record.created_at, count * 20]
    end
    @series = [ { :name => "Tapjoy, Inc.", :data => data } ]
    render :index
  end

private
  def find_user
    if current_user.admin?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
end
