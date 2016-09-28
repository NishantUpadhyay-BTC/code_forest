class CreateFavourites < ActiveRecord::Migration[5.0]
  def change
    create_table :favourites do |t|
      t.references :user, foreign_key: true
      t.references :repository, foreign_key: true

      t.timestamps
    end
  end
end
