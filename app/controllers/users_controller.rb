class UsersController < ApplicationController
  ASSOCIATIVE_COLUMNS = ['impressions', 'favourites']

# sort_data(resources, sort_by, sort_order, page, associative_column=false)
  def show
    pocs = Repository.where(author_name: current_user.name)
    repositories = Github::FetchAllRepos.new(current_user.name, session[:github_token]).call
    @pocs = sort_data(pocs, params[:column], params[:poc_sorting], params[:poc_page], ASSOCIATIVE_COLUMNS.include?(params[:column]))
    @repositories = sort_data(filter_pocs(repositories), "name", params[:repo_sorting], params[:repo_page])
    # pocs = Repository.where(author_name: current_user.name)
    # if COLUMNS_FOR_SORTING_WITH_ASSOCIATIVES.include?(params[:column])
    #   pocs = sort_with_association(pocs, params[:poc_sorting])
    # else
    #   pocs = pocs.order("#{params[:column]} #{params[:poc_sorting]}")
    # end
    # repositories = Github::FetchAllRepos.new(current_user.name, session[:github_token]).call
    # @repositories = filter_pocs(repositories).paginate(per_page: 1, page: params[:repo_page])
    # @pocs = pocs.paginate(per_page: 3, page: params[:poc_page])
  end

  private
  def sort_with_association(pocs, sorting_order)
    pocs = pocs.sort_by { |repo| repo.send(params[:column]).count }
    sorting_order == "ASC" ? pocs : pocs.reverse
  end
end
