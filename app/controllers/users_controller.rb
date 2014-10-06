require './lib/git_api_requests'

class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update, :destroy, :require_tree, :git_api_repos ]

  def index
    @users = User.all
  end

  def show
    @garden = Garden.new
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

  def require_tree
    
    request = GitHubApiRequest.new
    request.username = params[:owner]
    request.repository = params[:repo]
    foreign_tree = request.get_repo

    github = Github.new oauth_token: @user.token,
                        auto_pagination: true
    commits = github.repos.commits.all params[:owner], params[:repo]

    sha_key_dates = commits.flat_map{|commit| [commit["sha"], commit["commit"]["committer"]["date"]]}
    messages = commits.flat_map{|commit| [ commit['sha'], commit["commit"]["message"] ] }

    github = Github.new oauth_token: @user.token
    contributors = github.repos.contributors params[:owner], params[:repo]

    tree_map = Hash[ owner: foreign_tree['owner']['login'], name: foreign_tree['name'], language: foreign_tree['language'] , forks: foreign_tree['forks_count'], contributors: contributors.length, sha_key_dates: Hash[*sha_key_dates], messages: Hash[*messages] ]

    @garden = @user.gardens.create tree_map

    puts @user

    respond_to do |format|
      format.js
    end

  end

  def git_api_repos

    github = Github.new oauth_token: @user.token,
                        auto_pagination: true

    @repos = github.repos.list user: params[:owner]

    repository_names = @repos.map{ |repo| Hash[  name: repo.name,
                                                owner: repo.owner.login,
                                                language: repo.language, 
                                                forks: repo.forks_count
                                              ] 
                                             }

    @user.update_attributes(user_repos: repository_names)

    respond_to do |format|
      format.js
    end
  end

  private

  def find_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:github_username)
  end
    


end
