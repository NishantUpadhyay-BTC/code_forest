class Github::FetchRepo
  def self.repository_values(user_name, repository_name)
    repository = get_response(user_name, repository_name)
    language = get_response(user_name, repository_name, "/languages")
    user = Github::FetchUser.new(user_name)

    repository_details = {
      author_name: user["login"],
      avatar_url: user["avatar_url"],
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
      wiki_url: "http://github.com/#{repository["full_name"]}/wiki",
      repo_created_at: repository[:created_at],
      last_updated_at: repository[:updated_at]
    }

    { repository_details: repository_details, language: language }
  end

  private

  def self.get_response(user_name, repo_name, language_uri="")
    uri = URI("https://api.github.com/repos/#{user_name}/#{repo_name}" + language_uri)
    http_response = Net::HTTP.get_response(uri)
    JSON(http_response.body).symbolize_keys
  end
end
