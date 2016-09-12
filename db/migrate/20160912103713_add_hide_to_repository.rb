class AddHideToRepository < ActiveRecord::Migration[5.0]
  def change
    add_column :repositories, :hide, :boolean, default: false
  end
end
