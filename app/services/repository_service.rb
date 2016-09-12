require
class RepositoryService

  def initialize
    @client = Utilities::Github::Client.new
  end

  def self.call(user_name, repository_name)
    @client = Utilities::GitHub::Client.new
    repository = @client.repository(user_name, repository_name)
    language = Support::Common.get_response(repository[:languages_url])

    { repository_details: repository_details(repository), language: language }
  end

  private
    def repository_values(repository)
      {
      author_name: repository[:owner]["login"],
      avatar_url: repository[:owner]["avatar_url"],
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
    end
end
