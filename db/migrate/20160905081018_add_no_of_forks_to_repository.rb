class AddNoOfForksToRepository < ActiveRecord::Migration[5.0]
  def change
    add_column :repositories, :no_of_forks, :integer
  end
end
