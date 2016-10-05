class AddRepositoryToLanguages < ActiveRecord::Migration[5.0]
  def change
    add_reference :languages, :repository, foreign_key: true
  end
end
