require 'will_paginate/array'
class UsersController < ApplicationController
  def show
    @pocs = Repository.where(author_name: current_user.name).paginate(page: params[:poc_page]).order( "#{params[:column]} #{params[:sorting_order]}" )
    @repositories = Github::FetchAllRepos.new(current_user.name, session[:github_token]).call
    @repositories = filter_pocs(@repositories).paginate(per_page: 1, page: params[:repo_page])
    respond_to do |format|
        format.html
        format.js
    end
  end
end
