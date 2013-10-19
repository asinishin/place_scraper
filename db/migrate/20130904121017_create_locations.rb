class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :lat
      t.string :lng
      t.text :address
      t.string :web_address
      t.string :phone_number
      t.string :social_media_address

      t.timestamps
    end
  end
end
