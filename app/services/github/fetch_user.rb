class Github::FetchUser
  GITHUB_URI = "https://api.github.com/users/"

  def self.call_user(user_name)
    get_response(user_name)
  end

  def self.call_user_repos(user_name)
    get_response(user_name, "/repos")
  end

  private

  def self.get_response(user_name, repo_uri="")
    uri = URI(GITHUB_URI + "#{user_name}" + repo_uri)
    http_response = Net::HTTP.get_response(uri)
    JSON(http_response.body)
  end
end
