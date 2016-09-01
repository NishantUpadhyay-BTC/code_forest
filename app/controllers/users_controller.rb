class UsersController < ApplicationController
  def new
  end

  def index
    @repositories = response_from_uri("https://api.github.com/users/#{current_user.name}/repos")
  end

  def response_from_uri(uri)
    uri = URI(uri)
    http_response = Net::HTTP.get_response(uri)
    response = JSON(http_response.body)
    response
  end
end
