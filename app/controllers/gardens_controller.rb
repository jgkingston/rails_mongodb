require './lib/git_api_requests'

class GardensController < ApplicationController

  skip_before_action :authenticate_user!, only: [:webhook]
  before_action :load_user
  before_action :find_garden, only: [:show, :edit, :update, :destroy, :create_webhook, :webhook, :git_api_commits] 

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

    messages = commits.flat_map{|commit| [ commit['sha'], commit["commit"]["message"] ] }

    contributors = github.repos.contributors @garden.owner, @garden.name

    @garden.update_attributes(sha_key_dates: Hash[*sha_key_dates], contributors: contributors.length )


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
    end

    redirect_to root_path
  end

  def create_webhook
    _request = GitHubApiRequest.new
    _request.user_id = @user.id
    _request.repo_id = @garden.id
    _request.username = @garden.owner
    _request.repository = @garden.name

    puts "before create function"

    _request.create_webhook_dooooo

    puts "after create function"

    redirect_to root_path
  end

  def webhook

    if params["zen"]

      flash[:success] = "User successfully added."

    else

      payload = params["commits"]

      payload.each do |commit|
        url_list << commit['url']
      end

      commits = []

      url_list.each do |url|
        ret = HTTParty.get url, headers: {"User-Agent" => @user.github_username, "Authorization" => "token #{@user.token}"  }

        commits << ret.parsed_response
      end
      
      commits.each do |commit|
        commit = @garden.growth_rings.create(sha: commit["sha"], total: commit["stats"]["total"], additions: commit["stats"]["additions"], deletions: commit["stats"]["deletions"], message: commit["commit"]["message"])
      end

    end

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
