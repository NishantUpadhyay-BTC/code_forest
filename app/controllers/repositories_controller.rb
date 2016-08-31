class RepositoriesController < ApplicationController
  def initialize 
    @github ||= Github.new
  end

  def index
    @repository = response_from_uri("https://api.github.com/repos/Naiya123/app1")
    @language = response_from_uri(@repository[:languages_url])
    @total = @language.values.sum
  end

  def response_from_uri(uri)
    uri = URI(uri)
    http_response = Net::HTTP.get_response(uri)
    response = JSON(http_response.body).symbolize_keys
    response
  end
end
