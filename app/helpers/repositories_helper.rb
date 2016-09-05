module RepositoriesHelper
  def fav_repo(repo)
    if current_user.present? && current_user.is_favourited?(repo)
      "pink"
    else
      "grey"
    end
  end

  def language_graph(repo)
    total = repo.languages.pluck(:code).sum
    language_graph_array = []
    lang_with_percent = {}
    color = "#689f38"
    repo.languages.each do |lang|
      lang_with_percent[lang.name] = (lang.code.to_f/total.to_f)*100
    end
    lang_with_percent.each do |lang, percent|
      language_graph_array << [lang, percent.round(2), color]
    end
    language_graph_array
  end
end
