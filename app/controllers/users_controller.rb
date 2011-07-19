class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  before_filter :find_user, :only => [:edit, :update]
  def index
    @users = User.active
  end

  def show
    redirect_to edit_user_path
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash.now[:notice] = "Saved user!"
      redirect_to root_path and return
    else
      flash[:error] = "Unable to save user"
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
