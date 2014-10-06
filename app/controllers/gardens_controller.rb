require './lib/git_api_requests'

class GardensController < ApplicationController

  before_action :load_user
  before_action :find_garden, only: [:show, :edit, :update, :destroy, :git_api_commits] 

  def index
    respond_to do |format|
      format.js
    end
  end

  def show
    respond_to do |format|
      format.js
      # format.html
    end
  end

  def new
    @garden = Garden.new
  end

  def create
    @user = current_user
    @garden = @user.gardens.create garden_params
    if @garden.save == true
      redirect_to root_path
      flash[:success] = "Garden successfully added."
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @garden.update_attributes garden_params
      redirect_to user_garden_path(@user, @garden)
    else
      render :edit
    end
  end

  def destroy
    @garden.destroy
    redirect_to root_path
  end

  def git_api_commits

    github = Github.new oauth_token: @user.token,
                        auto_pagination: true

    commits = github.repos.commits.all @garden.owner, @garden.name

    sha_key_dates = commits.flat_map{|commit| [commit["sha"], commit["commit"]["committer"]["date"]]}

    github = Github.new oauth_token: @user.token,
                        auto_pagination: true

    contributors = github.repos.contributors @garden.owner, @garden.name

    # @garden.update_attributes(sha_keys: sha_keys)
    @garden.update_attributes(sha_key_dates: Hash[*sha_key_dates], contributors: contributors.length )


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
    params.require(:garden).permit(:owner, :name, :sha_key_dates, :messages, :language)
  end

end
