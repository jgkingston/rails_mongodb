require './lib/git_api_requests'

class GardensController < ApplicationController

  before_action :load_user
  before_action :find_garden, only: [:show, :edit, :update, :destroy, :git_api_commits] 

  def index
    @gardens = Garden.all
  end

  def show
    
  end

  def new
    @garden = Garden.new
  end

  def create
    @user = current_user
    @garden = @user.gardens.create garden_params
    if @garden.save == true
      redirect_to user_path(current_user)
      flash[:success] = "Garden successfully added."
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @garden.update_attributes garden_params
      redirect_to gardens_path
    else
      render :edit
    end
  end

  def destroy
    @garden.destroy
    redirect_to gardens_path
  end

  def git_api_commits

    request = GitHubApiRequest.new

    request.username = @user.github_username
    request.repository = @garden.name

    request.get_commits

    sha_keys = request.commits.map{|commit| commit["sha"]}

    @garden.update_attributes(sha_keys: sha_keys)

    # sha_keys.each do |sha|
    #   @garden.growth_rings.create(sha: sha)
    # end

    respond_to do |format|
      format.js
      # format.html
    end
  end

  private

  def load_user
    @user = User.find params[:user_id]
  end

  def find_garden
    @garden = @user.gardens.find params[:id]
  end

  def garden_params
    params.require(:garden).permit(:name, :sha_keys)
  end

end
