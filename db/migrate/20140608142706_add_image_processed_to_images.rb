class AddImageProcessedToImages < ActiveRecord::Migration
  def change
  	add_column :images, :image_processed, :boolean, default: false
  	add_column :images, :image_thumb, :string
  end
end
