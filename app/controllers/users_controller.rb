require 'will_paginate/array'
class UsersController < ApplicationController
  def show
    @pocs = Repository.where(author_name: current_user.name)
    @pocs = ['impressions', 'favourites'].include?(params[:column]) ?
           sort_with_association(@pocs)  :
           @pocs.order("#{params[:column]} #{params[:poc_sorting]}")
    @repositories = Github::FetchAllRepos.new(current_user.name, session[:github_token]).call
    @repositories = filter_pocs(@repositories).paginate(per_page: 1, page: params[:repo_page])
    @pocs = @pocs.paginate(page: params[:poc_page])
    respond_to do |format|
        format.html
        format.js
    end
  end

  private
  def sort_with_association(pocs)
    params[:poc_sorting] == "ASC" ?
    pocs = pocs.sort_by { |repo| repo.send(params[:column]).count } :
    pocs = pocs.sort_by { |repo| repo.send(params[:column]).count }.reverse
  end
end
