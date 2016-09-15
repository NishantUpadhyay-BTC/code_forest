class Github::FetchAllRepos
  def initialize(user_name)
    @user_name = user_name
    @github_client = Utilities::GithubApi::Client.new
  end

  def call
    @github_client.fetch_all_repositories(@user_name)
  end
end
