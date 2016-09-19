module RepositoriesHelper
  FAV_REPO_COLOR = "pink"
  UNFAV_REPO_COLOR = "grey"
  GRAPH_COLOR = "#689f38"

  def fav_repo(repo)
    if current_user.present? && current_user.is_favourited?(repo)
      FAV_REPO_COLOR
    else
      UNFAV_REPO_COLOR
    end
  end

  def languages_for_option
    language_options = ['All']
    language_options << Language.pluck(:name).uniq
    language_options = language_options.flatten
    language_options.zip(language_options)
  end

  def language_graph(repo)
    total = @repository.lang_repos.collect{|lr| lr.code}.sum
    language_graph_array = []
    lang_with_percent = {}
    color = GRAPH_COLOR
    repo.lang_repos.each do |lr|
      lang_with_percent[lr.language.name] = (lr.code.to_f/total.to_f)*100
    end
    lang_with_percent.each do |lang, percent|
      language_graph_array << [lang, percent.round(2), color]
    end
    language_graph_array
  end

  def update_repo(description, tag_list )
    @repository.description = description
    @repository.tag_list = tag_list
  end

  def hidden_fields_array
    [:avatar_url, :name, :private, :download_link, :clone_url, :git_url, :ssh_url, :author_name,
     :svn_url, :no_of_stars, :no_of_watchers, :has_wiki, :wiki_url, :repo_created_at,
     :last_updated_at, :no_of_downloads, :no_of_views, :no_of_bookmarks, :description, :tag_list]
  end

  def display_tag
    tags = ""
    @repository.tag_list.each do |tag|
      tags += "<div class='chip'>#{tag}</div>"
    end
    tags.html_safe
  end
end
