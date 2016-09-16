class RemoveCodeFromLanguage < ActiveRecord::Migration[5.0]
  def change
    remove_column :languages, :code, :integer
  end
end
