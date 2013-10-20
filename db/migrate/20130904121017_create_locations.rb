class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name, :limit => 50,   :null => false
      t.string :lat,                  :null => false
      t.string :lng,                  :null => false
      t.text   :address,              :null => false
      t.string :web_address,          :null => false
      t.string :phone_number,         :null => false
      t.string :social_media_address, :null => false

      t.timestamps
    end
  end
end
