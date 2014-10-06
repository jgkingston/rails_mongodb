class SessionsController < ApplicationController

  def create

    current_user.update_attributes(token: auth_hash["credentials"]["token"]) 

    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
