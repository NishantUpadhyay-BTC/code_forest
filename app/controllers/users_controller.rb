class UsersController < ApplicationController
  def new
  end

  def index
    @repositories = Github::FetchUser.call_user_repos(current_user.name)
  end

  def show
    @pocs = Repository.where(author_name: current_user.name)
    @repositories = Github::FetchUser.call_user_repos(current_user.name)
  end
end
