class LanguageGraphData
  GRAPH_COLOR = "#689f38"
  attr_accessor :repo

  def initialize(repo)
    @repo = repo
  end

  def call
    total = repo.language_repositories.collect{|lr| lr.code}.sum
    language_graph_array = []
    lang_with_percent = {}
    color = GRAPH_COLOR
    repo.language_repositories.each do |lr|
      lang_with_percent[lr.language.name] = (lr.code.to_f/total.to_f)*100
    end
    lang_with_percent.each do |lang, percent|
      language_graph_array << [lang, percent.round(2), color]
    end
    language_graph_array
  end
end
