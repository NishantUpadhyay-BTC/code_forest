require 'will_paginate/array'
class RepositoriesController < ApplicationController
  def index
    @repositories = paginated(Repository.unhide_repos, params[:page])
  end

  def show
    @repository = initialize_repo
    @language_graph = LanguageGraphData.new(@repository).call
    impressionist(@repository, nil, { unique: [:session_hash] })
  end

  def new
    repository_values_result = Github::FetchRepo.new(params[:user_name], params[:repo_name], session[:github_token]).call
    @repository = Repository.new(repository_values_result[:repository_details])
    repository_values_result[:language].each do |language,code|
      new_language = Language.find_or_create_by(name: language)
      @repository.language_repositories.build(language_id: new_language.id, code: code, repository_id: @repository.id)
    end
    @language_graph = LanguageGraphData.new(@repository).call
  end

  def edit
    @repository = initialize_repo
  end

  def create
    @repository = Repository.new(repository_params)
    if @repository.save
      flash[:green] = "POC is created successfully..!"
      redirect_to repositories_path
    else
      flash[:red] = @repository.errors.full_messages.first
      redirect_back(fallback_location: new_repository_path(user_name: params[:repository][:author_name], repo_name: params[:repository][:name]))
    end
  end

  def update
    @repository = initialize_repo
    updated = @repository.update_attributes(repository_params)
    flash[:green] = "POC #{@repository.name} updated successfully..!" if updated
    redirect_to repositories_path
  end

  def favourite
    @repository = initialize_repo
    @message = ""
    if current_user.present?
      if current_user.is_favourited?(@repository)
        current_user.favourites.find_by_repository_id(params[:id]).destroy
        @message = "POC #{@repository.name} removed from your favourites..!"
      else
        current_user.favourites.build(repository_id: params[:id])
        current_user.save
        @message = "POC #{@repository.name} added to your favourites..!"
      end
    end
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end

  def destroy
    destroyed = initialize_repo.destroy
    @message = "POC Removed successfully..!" if destroyed
    @pocs = paginated(Repository.where(author_name: current_user.name), params[:poc_page])
    @repositories = Github::FetchAllRepos.new(current_user.name, session[:github_token]).call
    @repositories = filter_pocs(@repositories).paginate(per_page:1, page: params[:repo_page])
    redirect_to user_path(params[:user_id])
  end

  def search
    @repositories = paginated(Repository.search_repo(params[:key_word], params[:language]), params[:page])
  end

  def search
    @repositories = paginated(Repository.search_repo(params[:key_word], params[:language]), page: params[:page])
  end

  def total_downloads
    repo = initialize_repo
    repo.no_of_downloads = repo.no_of_downloads.to_i + 1
    repo.save
  end

  def hide
    repository = initialize_repo
    repository.update_attribute(:hide, !repository.hide)
  end

  def search_by_tag
    @repositories = Repository.tagged_with(params[:tag])
    render :index
  end

  private

  def repository_params
    params.require(:repository).permit(:id, :author_name, :avatar_url, :repo_id,
                  :name, :description, :private, :download_link, :clone_url,
                  :git_url, :ssh_url, :svn_url, :no_of_stars, :no_of_watchers,
                  :no_of_downloads, :no_of_views, :no_of_bookmarks, :has_wiki,
                  :wiki_url, :repo_created_at, :last_updated_at, :poc_image,
                  :tag_list, language_repositories_attributes: [:id, :repository_id, :language_id , :code])
  end

  def initialize_repo
    Repository.find(params[:id])
  end
end
