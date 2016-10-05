class Github::FetchRepo
  attr_accessor :user_name, :repository_name, :github_client
  def initialize(user_name, repository_name, oauth_token)
    @user_name = user_name
    @repository_name = repository_name
    @github_client = Utilities::GithubApi::Client.new(oauth_token)
  end

  def call
    github_client.fetch_repository(user_name, repository_name)
  end
end
