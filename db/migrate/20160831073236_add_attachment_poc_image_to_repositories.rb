class AddAttachmentPocImageToRepositories < ActiveRecord::Migration
  def self.up
    change_table :repositories do |t|
      t.attachment :poc_image
    end
  end

  def self.down
    remove_attachment :repositories, :poc_image
  end
end
