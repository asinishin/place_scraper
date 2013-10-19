class Location < ActiveRecord::Base
  attr_accessible :address, :lat, :lng, :name, :phone_number, :reference_key, :social_media_address, :web_address
end
