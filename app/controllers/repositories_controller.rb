class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.where(hide: false).paginate(:page => params[:page])
    respond_to do |format|
        format.html
        format.js
    end
  end

  def show
    @repository = Repository.find(params[:id])
    impressionist(@repository, nil, { unique: [:session_hash] })
  end

  def new
    repository_values_result = Github::FetchRepo.new(params[:user_name], params[:repo_name], session[:github_token]).call
    @repository = Repository.new(repository_values_result[:repository_details])
    repository_values_result[:language].each do |language,code|
      l = Language.find_or_create_by(name: language);
      @repository.lang_repos.build(language_id: l.id, code: code, repository_id: @repository.id)
      # @repository.languages.push l
      # @repository.lang_repos.each do |lr|
      #   lr.code = code if lr.language == l
      # end
    end
  end

  def edit
    @repository = Repository.find_by(params[:id])
  end

  def create
    @repository = Repository.new(repository_params)
    binding.pry
    save = @repository.save!
    redirect_to repositories_path
  end

  def edit
    @repository = Repository.find(params[:id])
  end

  def update
    @repository = Repository.find(params[:id])
    @repository.update_attributes(repository_params)
    redirect_to repositories_path
  end

  def favourite
    @repository = Repository.find(params[:id])
    if current_user.present?
      if current_user.is_favourited?(@repository)
        current_user.favourites.find_by_repository_id(params[:id]).destroy
      else
        current_user.favourites.build(repository_id: params[:id])
        current_user.save
      end
    end
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end

  def destroy
    Repository.find(params[:id]).destroy
    @pocs = Repository.where(author_name: current_user.name)
    @repositories = Github::FetchAllRepos.new(current_user.name, session[:github_token]).call
    respond_to do |format|
       format.js
    end
  end

  def search
    @repositories = Repository.search_repo(params[:key_word], params[:language]).paginate(page: params[:page])
    respond_to do |format|
       format.js
   end
  end

  def total_downloads
    repo = Repository.find(params[:id])
    repo.no_of_downloads = repo.no_of_downloads.to_i + 1
    repo.save
  end

  def hide
    repository = Repository.find(params[:id])
    repository.update_attribute(:hide, !repository.hide)
  end
  private

  def repository_params
    params.require(:repository).permit(:id, :author_name, :avatar_url, :repo_id, :name, :description, :private,
                  :download_link, :clone_url, :git_url, :ssh_url, :svn_url, :no_of_stars, :no_of_watchers,
                  :no_of_downloads, :no_of_views, :no_of_bookmarks,
                  :has_wiki, :wiki_url, :repo_created_at, :last_updated_at, :poc_image, :tag_list, lang_repos_attributes: [:id, :repository_id, :language_id , :code])
  end
end
