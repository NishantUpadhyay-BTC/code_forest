class CreateLangRepos < ActiveRecord::Migration[5.0]
  def change
    create_table :lang_repos do |t|
      t.references :repository, foreign_key: true
      t.references :language, foreign_key: true
      t.integer :code

      t.timestamps
    end
  end
end
