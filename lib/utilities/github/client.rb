require 'github'
module Utilities
  module GitHub
    class Client
      def initialize
        @github = Github.new
      end

      def repository(user_name, repository_name)
        all_repos = @github.repos.list(user: user_name)
        all_repos = all_repos.body
        repository = all_repos.select {|repo| repo[:name] == repository_name }.first
        repository.symbolize_keys
      end
    end
  end
end
