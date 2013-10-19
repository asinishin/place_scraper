class AddIndexToLocations < ActiveRecord::Migration
  def change
    add_index(:locations, :reference_key, unique: true)
  end
end
