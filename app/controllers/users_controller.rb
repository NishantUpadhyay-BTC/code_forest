class UsersController < ApplicationController
  ASSOCIATIVE_COLUMNS = ['impressions', 'favourites']

  def show
    pocs = Repository.where(author_name: current_user.name)
    repositories = Github::FetchAllRepos.new(current_user.name, session[:github_token]).call
    @pocs = sort_data(pocs, params[:column], params[:poc_sorting], params[:poc_page], ASSOCIATIVE_COLUMNS.include?(params[:column]))
    @repositories = sort_data(filter_pocs(repositories), "name", params[:repo_sorting], params[:repo_page])
  end
end
