desc "Fetch Location's"
task :fetch_location => :environment do
  lat, lng = ENV['lat'].to_f, ENV['lng'].to_f # 43.65..43.90, -79.30..-79.55 (step:0.05 * 5)
  5.times.each do |lat_step|
    5.times.each do |lng_step|
      ::GOOGLE_PLACES.spots(
	lat + lat_step * 0.05,
	lng - lng_step * 0.05,
	radius: ENV["radius"], # 4000
	types: "storage",
	keyword: "self storage",
	multipage: true).each do |gp|
	  unless Location.where('lat = ? AND lng = ?', gp.lat.round(7), gp.lng.round(7)).first
	    details = ::GOOGLE_PLACES.spot(gp.reference)
	    Location.create(
	      name:          gp.name[0..49],
	      address:       (gp.formatted_address || gp.vicinity || '*'),
	      lat:           gp.lat.round(7),
	      lng:           gp.lng.round(7),
	      web_address:   (details.website || '*')[0..249],
	      phone_number:  (details.formatted_phone_number || '-')[0..19],
	      social_media_address: (details.url || '*')[0..249]
	    )
	  end
      end # each spot
    end
  end
  puts "Fetching locations successfully done."
end
