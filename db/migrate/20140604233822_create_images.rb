class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image_file

      t.timestamps
    end
  end
end
