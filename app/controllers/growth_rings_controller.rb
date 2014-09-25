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
    request.username = @user.github_username
    request.repository = @garden.name

    request.get_detailed_commits @garden.sha_keys

    @commits = request.detailed_commits
    
    @commits.each do |commit|
      commit = @garden.growth_rings.create(sha: commit["sha"], total: commit["stats"]["total"], additions: commit["stats"]["additions"], deletions: commit["stats"]["deletions"], message: commit["commit"]["message"])
    end

    redirect_to user_garden_path(@user, @garden)

  end

  def edit
    
  end

  def update
    # request = GitHubApiRequest.new
    # request.username = @user.github_username
    # request.repository = @garden.name
    # request.get_commit @growth_ring.sha

    # stats = request.extract_commit_stats
    # p stats
    # @growth_ring.total = stats['total']
    # @growth_ring.additions = stats['additions']
    # @growth_ring.deletions = stats['deletions']
    # @growth_ring.message = stats['message']
    # @user.save
   
    @growth_ring.update_attributes!(total: 42)

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
