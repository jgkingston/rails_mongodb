class GrowthRingsController < ApplicationController

  before_action :load_user
  before_action :load_garden

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
    sha = params[:q]

    url = "https://api.github.com/repos/" + "#{@user.github_username}" + "/" + "#{r@garden.name}" + "/commits/" + "#{sha}"

    ret = HTTParty.get url, headers: {"User-Agent" => "#{@user.github_username}"}

    @git_commit = ret.parsed_response



    @commit = @garden.commits.create commit_params

    respond_to do |format|
      format.js
      format.html
    end
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private

  def find_growth_ring
    
  end

  def load_garden
    load_user
    @garden = @user.gardens.find params[:garden_id]
  end

  def load_user
    @user = User.find params[:user_id]
  end

end
