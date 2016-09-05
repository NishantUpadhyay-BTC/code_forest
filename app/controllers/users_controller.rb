class UsersController < ApplicationController
  def new
  end

  def index
    @repositories = response_from_uri("https://api.github.com/users/#{current_user.name}/repos")
  end

  def show
    @pocs = Repository.where(author_name: current_user.name)
    @repositories = response_from_uri("https://api.github.com/users/#{current_user.name}/repos")
  end

  def destory
    redirect_to :back
  end
  
  def response_from_uri(uri)
    uri = URI(uri)
    http_response = Net::HTTP.get_response(uri)
    response = JSON(http_response.body)
    response
  end
end
