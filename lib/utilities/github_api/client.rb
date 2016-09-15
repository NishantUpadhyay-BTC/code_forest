module Utilities
  module GithubApi
    class Client
      def initialize
        @github = Github.new
      end

      def fetch_repository(user_name, repository_name)
        repository = fetch_repo_info_from_github(user_name, repository_name)
        language = get_response(repository[:languages_url])
        { repository_details: repository_details(repository), language: language }
      end

      private
      def get_response(uri)
        uri = URI(uri)
        http_response = Net::HTTP.get_response(uri)
        JSON(http_response.body).symbolize_keys
      end

      def fetch_repo_info_from_github(user_name, repository_name)
        begin
          all_repos = @github.repos.list(user: user_name).body
        rescue => e
          flash[:red] = "API Limit Exceed for Github: #{e}"
          redirect_to repositories_path
        end
        repository = all_repos.select{ |repo| repo["name"] == repository_name }.first
        repository.symbolize_keys
      end

      def repository_details(repository)
        {
          author_name: repository[:owner][:login],
          avatar_url: repository[:owner][:avatar_url],
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
  end
end
