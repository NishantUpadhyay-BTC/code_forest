class RepositoriesController < ApplicationController
  # def initialize
  #   @github = Github.new
  # end

  def index
    @repositories = Repository.all
  end

  def show
    # binding.pry
    @repository = Repository.find(params[:id])
    # @repository = response_from_uri("https://api.github.com/repos/NishantUpadhyay-BTC/code_forest")
    @language = response_from_uri(@repository[:languages_url])
    @total = @language.values.sum
    @user = author_info('rails')
  end

  def new
    repository_values_result = repository_values('NishantUpadhyay-BTC', 'code_forest')
    @repository = Repository.new(repository_values_result[:repository_details])

    repository_values_result[:language].each do |language,code|
      @repository.languages.build(name: language, code: code)
    end

    impressionist(@repository, nil, { unique: [:session_hash] })
  end

  def create
    @repository = Repository.new(repository_params)
    save = @repository.save
    redirect_to repositories_path
  end

  private
  def response_from_uri(uri)
    binding.pry
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
    binding.pry
    repository = response_from_uri("https://api.github.com/repos/#{user_name}/#{repository_name}")
    language = response_from_uri(repository[:languages_url])
    user = author_info(user_name)

    repository_details = {
      author_name: user[:login],
      avatar_url: user[:avatar_url],
      repo_id: repository[:id],
      name: repository[:name],
      description: repository[:description],
      private: repository[:private],
      download_link: "https://github.com/#{repository[:full_name]}/archive/#{repository[:default_branch]}.zip",
      clone_url: repository[:clone_url],
      git_url: repository[:git_url],
      ssh_url: repository[:ssh_url],
      svn_url: repository[:svn_url],
      no_of_stars: repository[:stargazers_count],
      no_of_watchers: repository[:forks],
      has_wiki: repository[:has_wiki],
      wiki_url: "http://github.com/#{repository[:full_name]}/wiki",
      repo_created_at: repository[:created_at],
      last_updated_at: repository[:updated_at]
      }

    {repository_details: repository_details, language: language}
  end

  def repository_params
    params.require(:repository).permit(:id, :author_name, :avatar_url, :repo_id, :name, :description, :private,
                  :download_link, :clone_url, :git_url, :ssh_url, :svn_url, :no_of_stars, :no_of_watchers,
                  :no_of_downloads, :no_of_views, :no_of_bookmarks,
                  :has_wiki, :wiki_url, :repo_created_at, :last_updated_at, :poc_image, :tag_list, languages_attributes: [:id, :repository_id, :name, :code])
  end
end
