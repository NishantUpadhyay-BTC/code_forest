class Github::FetchAllRepos
  attr_accessor :user_name, :github_client
  def initialize(user_name, oauth_token)
    @user_name = user_name
    @github_client = Utilities::GithubApi::Client.new(oauth_token)
  end

  def call
    github_client.fetch_all_repositories(user_name)
  end
end
