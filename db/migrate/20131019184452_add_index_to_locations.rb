class AddIndexToLocations < ActiveRecord::Migration
  def change
    add_index(:locations, :name, unique: true)
  end
end
