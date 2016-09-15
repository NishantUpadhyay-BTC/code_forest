class UsersController < ApplicationController
  def show
    @pocs = Repository.where(author_name: current_user.name)
    @repositories = Github::FetchAllRepos.new(current_user.name, session[:github_token]).call
  end
end
