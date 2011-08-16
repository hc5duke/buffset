class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only
  layout 'admin'

  def index
    @active_users = User.all(:conditions => ['active = ?', true])
    @inactive_users = User.all(:conditions => ['active != ?', true])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Saved user!"
      redirect_to admin_users_path
    else
      flash.now[:error] = "Unable to save user"
      render :action => :edit
    end
  end
end
