class UsersController < ApplicationController


  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.create user_params
    if @user.save == true
      redirect_to users_path
      flash[:success] = "User successfully added."
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @user.update_attributes user_params
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def find_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:content)
  end
    


end
