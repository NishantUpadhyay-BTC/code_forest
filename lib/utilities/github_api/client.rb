module Utilities
  module GithubApi
    include Support
    class Client
      include Support
      def initialize(oauth_token)
        @github = Github.new(oauth_token: oauth_token)
      end

      def fetch_repository(user_name, repository_name)
        begin
          all_repos = @github.repos.list(user: user_name).body
          repository = all_repos.select{ |repo| repo["name"] == repository_name }.first.symbolize_keys
          language =  Support::Common.get_response(repository[:languages_url])
          { repository_details: repository_details(repository), language: language }
        rescue => e
          #write code for handling exception
        end
      end

      def fetch_all_repositories(user_name)
        begin
          @github.repos.list(user: user_name).body
        rescue => e
          #write code for handling exception
        end
      end

      private
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
