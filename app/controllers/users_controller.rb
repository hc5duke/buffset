class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  def index
    @users = User.all
  end

  def show
    redirect_to edit_user_path
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash.now[:notice] = "Saved user!"
      redirect_to root_path and return
    else
      flash[:error] = "Unable to save user"
      render :action => :edit and return
    end
  end
end
