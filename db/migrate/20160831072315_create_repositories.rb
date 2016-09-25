class CreateRepositories < ActiveRecord::Migration[5.0]
  def change
    create_table :repositories do |t|
      t.string :author_name
      t.string :avatar_url
      t.integer :repo_id
      t.string :name
      t.string :description
      t.boolean :private
      t.string :download_link
      t.string :clone_url
      t.string :git_url
      t.string :ssh_url
      t.string :svn_url
      t.integer :no_of_stars
      t.integer :no_of_watchers
      t.boolean :has_wiki
      t.string :wiki_url
      t.date :repo_created_at
      t.date :last_updated_at
      t.integer :no_of_downloads
      t.integer :no_of_views
      t.integer :no_of_bookmarks

      t.timestamps
    end
  end
end
