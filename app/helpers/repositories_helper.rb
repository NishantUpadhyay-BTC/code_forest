module RepositoriesHelper
  FAV_REPO_COLOR = "pink"
  UNFAV_REPO_COLOR = "grey"
  AVAILABLE_LOGOS = ["C", "CoffeeScript", "CSS", "HTML", "Java",
    "JavaScript", "Perl", "Rouge", "Ruby", "Shell", "Visual Basic"]

  def fav_repo(repo)
    if current_user.present? && current_user.is_favourited?(repo)
      FAV_REPO_COLOR
    else
      UNFAV_REPO_COLOR
    end
  end

  def languages_for_option
    language_options = ['Filter by', 'All']
    language_options << Language.pluck(:name).uniq.sort
    language_options = language_options.flatten
    options = language_options.zip(language_options)
    options.first.push({disabled: true, selected: true})
    options
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

  def highest_used_language(repository)
    language = repository.language_repositories.sort_by{|l| l.code}.last.language.name
    image = AVAILABLE_LOGOS.include?(language) ? language : "Default"
    {language: language, image: image}
  end
end
