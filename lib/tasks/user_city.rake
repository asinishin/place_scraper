desc "Assign users to cities"
namespace :user do
  task :city => :environment do
    puts "Processing..."
    
    User.all.each do |user|
      addr = user.user_address
      if addr
	city_seo = CitySeo.nearest(addr.latitude, addr.longitude)
	if city_seo
	  user.update_column(:city_seo_id, city_seo.id)
	  puts "Done with user: #{user.email}"
	else
	  puts "User: #{user.email} has problem with address"
	end
      else # Try address from listings
        #listing = HostingDescription.complete_listings(user.id).first
        listing = user.hosting_descriptions.complete_listings.first
	if listing && (addr = listing.space_address)
	  city_seo = CitySeo.nearest(addr.latitude, addr.longitude)
	  if city_seo
	    user.update_column(:city_seo_id, city_seo.id)
	    puts "Done with user: #{user.email}"
	  else
	    puts "Listing: #{listing.id} of user: #{user.email} has problem with address"
	  end
	end
      end
    end

    puts "Complete."
  end
end
