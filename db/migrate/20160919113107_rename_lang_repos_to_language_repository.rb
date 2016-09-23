class RenameLangReposToLanguageRepository < ActiveRecord::Migration[5.0]
  def change
    rename_table :lang_repos, :language_repositories
  end
end
