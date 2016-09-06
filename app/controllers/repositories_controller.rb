class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find(params[:id])
    impressionist(@repository, nil, { unique: [:session_hash] })
  end

  def new
    repository_values_result = repository_values(params[:user_name], params[:repo_name])
    @repository = Repository.new(repository_values_result[:repository_details])

    repository_values_result[:language].each do |language,code|
      @repository.languages.build(name: language, code: code)
    end
  end

  def edit
    @repository = Repository.find_by(params[:id])
  end

  def preview
    @repository = Repository.new(repository_params)
  end

  def create
    @repository = Repository.new(repository_params)
    save = @repository.save
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
    redirect_to :back
  end

  private
  def response_from_uri(uri)
    uri = URI(uri)
    http_response = Net::HTTP.get_response(uri)
    response = JSON(http_response.body).symbolize_keys
    response
  end

  #returns authors infor from github id.
  def author_info(user_name)
    user_info = response_from_uri("https://api.github.com/users/#{user_name}")
  end

  #returns repository details for initializing @repository object in new action
  #returns hash of languages used in that repository
  def repository_values(user_name, repository_name)
    # repository = response_from_uri("https://api.github.com/repos/#{user_name}/#{repository_name}")
    # language = response_from_uri(repository[:languages_url])
    # user = author_info(user_name)

    # repository_details = {
    #   author_name: user[:login],
    #   avatar_url: user[:avatar_url],
    #   repo_id: repository[:id],
    #   name: repository[:name],
    #   description: repository[:description],
    #   private: repository[:private],
    #   download_link: "https://github.com/#{repository[:full_name]}/archive/#{repository[:default_branch]}.zip",
    #   clone_url: repository[:clone_url],
    #   git_url: repository[:git_url],
    #   ssh_url: repository[:ssh_url],
    #   svn_url: repository[:svn_url],
    #   no_of_stars: repository[:stargazers_count],
    #   no_of_watchers: repository[:forks],
    #   has_wiki: repository[:has_wiki],
    #   wiki_url: "http://github.com/#{repository[:full_name]}/wiki",
    #   repo_created_at: repository[:created_at],
    #   last_updated_at: repository[:updated_at]
    #   }

    # {repository_details: repository_details, language: language}

    {:repository_details=>
  {:author_name=>"NishantUpadhyay-BTC",
   :avatar_url=>"https://avatars.githubusercontent.com/u/6542029?v=3",
   :repo_id=>66931911,
   :name=>"code_forest",
   :description=>"Largest collection of demo projects and proof of concepts",
   :private=>false,
   :download_link=>"https://github.com/NishantUpadhyay-BTC/code_forest/archive/master.zip",
   :clone_url=>"https://github.com/NishantUpadhyay-BTC/code_forest.git",
   :git_url=>"git://github.com/NishantUpadhyay-BTC/code_forest.git",
   :ssh_url=>"git@github.com:NishantUpadhyay-BTC/code_forest.git",
   :svn_url=>"https://github.com/NishantUpadhyay-BTC/code_forest",
   :no_of_stars=>1,
   :no_of_watchers=>0,
   :has_wiki=>true,
   :wiki_url=>"http://github.com/NishantUpadhyay-BTC/code_forest/wiki",
   :repo_created_at=>"2016-08-30T10:43:54Z",
   :last_updated_at=>"2016-09-02T06:06:01Z"},
 :language=>{:Ruby=>24670, :HTML=>5154, :JavaScript=>1201, :CSS=>736}}
  end

  def repository_params
    params.require(:repository).permit(:id, :author_name, :avatar_url, :repo_id, :name, :description, :private,
                  :download_link, :clone_url, :git_url, :ssh_url, :svn_url, :no_of_stars, :no_of_watchers,
                  :no_of_downloads, :no_of_views, :no_of_bookmarks,
                  :has_wiki, :wiki_url, :repo_created_at, :last_updated_at, :poc_image, :tag_list, languages_attributes: [:id, :repository_id, :name, :code])
  end
end
