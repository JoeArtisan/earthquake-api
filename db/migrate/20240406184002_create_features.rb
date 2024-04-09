class CreateFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :features do |t|
      t.string :usgs_id, null: false
      t.float :mag
      t.string :place, null: false
      t.integer :time
      t.string :url, null: false
      t.boolean :tsunami
      t.string :mag_type, null: false
      t.string :title, null: false
      t.float :longitude, null: false
      t.float :latitude, null: false

      t.timestamps
    end
  end
end
