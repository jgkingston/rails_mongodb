class GardensController < ApplicationController

  before_action :load_user
  before_action :find_garden, only: [:show, :edit, :update, :destroy, :git_user_repo_events, :retrieve_git_commit] 

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

  def git_user_repo_events

    repo_name = params[:q]

    url = "https://api.github.com/repos/" + "#{@user.github_username}" + "/" + "#{@garden.name}" + "/events"

    ret = HTTParty.get url, headers: {"User-Agent" => "#{@user.github_username}"}

    @repo_events = ret.parsed_response.select{ |event| event["type"] == "PushEvent"}

    respond_to do |format|
      format.js
      format.html
    end
  end

  def retrieve_git_commit

    sha = params[:q]

    url = "https://api.github.com/repos/" + "#{@user.github_username}" + "/" + "#{r@garden.name}" + "/commits"

    ret = HTTParty.get url, headers: {"User-Agent" => "#{@user.github_username}"}

    @repo_events = ret.parsed_response

    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def load_user
    @user = User.find params[:user_id]
  end

  def find_garden
    @user = load_user
    @garden = @user.gardens.find params[:id]
  end

  def garden_params
    params.require(:garden).permit(:name)
  end

end
