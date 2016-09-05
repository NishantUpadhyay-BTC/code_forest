module RepositoriesHelper
  def hidden_fields_array
    [:avatar_url, :name , :private , :download_link , :clone_url , :git_url , :ssh_url , :svn_url , :no_of_stars , :no_of_watchers , :has_wiki , :wiki_url , :repo_created_at , :last_updated_at , :no_of_downloads , :no_of_views , :no_of_bookmarks]
  end

  def language_graph(repo)
    total = 12345
    language_graph_array = []
    color = "#689f38"
    repo.languages.each do |language|
      language_graph_array.push([language.name, 25.00, color])
    end
    language_graph_array
  end
end
