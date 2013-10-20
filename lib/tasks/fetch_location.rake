desc "Fetch Location's"
task :fetch_location => :environment do
  lat, lng = ENV['lat'].to_f, ENV['lng'].to_f # 43.65..43.90, -79.30..-79.55 (step:0.05 * 5)
  5.times.each do |lat_d|
    5.times.each do |lng_d|
      ::GOOGLE_PLACES.spots(
	lat + lat_d,
	lng - lng_d,
	radius: ENV["radius"],
	types: "storage",
	keyword: "self storage",
	multipage: true).each do |gp|
	  details = ::GOOGLE_PLACES.spot(gp.reference)
	  unless Location.where('reference_key = ?', details.reference).first
	    Location.create(
	      reference_key: details.reference,
	      name:          gp.name[0..49],
	      address:       (gp.formatted_address || gp.vicinity),
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
