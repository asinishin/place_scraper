class AddIndexToLocations < ActiveRecord::Migration
  def change
    add_index(:locations, [:lat, :lng], unique: true)
  end
end
