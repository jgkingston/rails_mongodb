require './lib/git_api_requests'

class GrowthRingsController < ApplicationController

  before_action :load_user
  before_action :load_garden
  before_action :find_growth_ring, only: [:show, :edit, :update, :destroy]

  def index
    
  end

  def show
    
  end

  def new
    sha = params[:q]

    url = "https://api.github.com/repos/" + "#{@user.github_username}" + "/" + "#{@garden.name}" + "/commits/" + "#{sha}"

    ret = HTTParty.get url, headers: {"User-Agent" => "#{@user.github_username}"}

    @git_commit = ret.parsed_response
  end

  def create

    request = GitHubApiRequest.new
    request.username = @garden.owner
    request.repository = @garden.name

    request.get_detailed_commits @garden.sha_key_dates, @garden.last_updated

    commits = request.detailed_commits
    
    commits.each do |commit|
      commit = @garden.growth_rings.create(sha: commit["sha"], total: commit["stats"]["total"], additions: commit["stats"]["additions"], deletions: commit["stats"]["deletions"], message: commit["commit"]["message"])
    end

    if commits.length > 0
      @garden.update_attributes(last_updated: commits[0]["commit"]["committer"]["date"])
      redirect_to root_path
    end

    
    redirect_to root_path
  end

  def edit
    
  end

  def update
   
    @growth_ring.update_attributes growth_ring_params

    redirect_to user_garden_path(@user, @garden)
  end

  def destroy
    @growth_ring.destroy
    redirect_to user_garden_path(@user, @garden)
  end

  def method_name
    
  end

  private

  def find_growth_ring
    load_garden
    @growth_ring = @garden.growth_rings.find params[:id]
  end

  def load_garden
    load_user
    @garden = @user.gardens.find params[:garden_id]
  end

  def load_user
    @user = User.find params[:user_id]
  end

  def growth_ring_params
    params.require(:growth_ring).permit(:total, :additions, :deletions, :message)
  end

end
