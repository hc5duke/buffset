class UsersController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate_user!, :except => [:index, :chart]
  before_filter :find_active_users, :only => [:index, :chart]
  before_filter :find_user, :only => [:show, :edit, :update]

  def index
    @users_hash = {}
    @users.each do |user|
      unless user == current_user
        @users_hash[user.id] = {
          :name  => user.name,
          :count => user.pushup_set_count,
          :tally => user.pushup_set_count.to_i.tallyize(is_mobile?, params[:format] == 'json')
        }
      end
    end

    respond_to do |format|
      format.json { render :json => @users_hash }
      format.html
    end
  end

  def show
    @series = [
      {
        :name => @user.handle,
        :data => @user.pushup_histories.map{|pushup| [pushup.created_at, pushup.count.to_i * pushup.multiplier]}
      }
    ]
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Saved user!"
      redirect_to root_path and return
    else
      flash.now[:error] = "Unable to save user"
      render :action => :edit and return
    end
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
