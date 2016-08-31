class RepositoriesController < ApplicationController
  def initialize 
    @github ||= Github.new
  end

  def index
    @repository = response_from_uri("https://api.github.com/repos/rails/rails")
    @language = response_from_uri(@repository[:languages_url])
    @total = @language.values.sum
    @user = author_info('rails')
  end

  private
  def response_from_uri(uri)
    uri = URI(uri)
    http_response = Net::HTTP.get_response(uri)
    response = JSON(http_response.body).symbolize_keys
    response
  end

  def author_info(user_name)
    user_info = response_from_uri("https://api.github.com/users/#{user_name}")
  end
end
