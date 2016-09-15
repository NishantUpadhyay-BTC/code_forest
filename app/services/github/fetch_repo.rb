class Github::FetchRepo
  def initialize(user_name, repository_name)
    @user_name = user_name
    @repository_name = repository_name
    @github_client = Utilities::GithubApi::Client.new
  end

  def call
    @github_client.fetch_repository(@user_name, @repository_name)
  end
end
