desc "Fetch Location's"
task :fetch_location => :environment do
  ::GOOGLE_PLACES.spots(
    ENV["lat"],
    ENV["lng"],
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
	  lat:           gp.lat,
	  lng:           gp.lng,
	  web_address:   (details.website || '*'),
	  phone_number:  (details.formatted_phone_number || '-'),
	  social_media_address: (details.url || '*')
	)
      end
  end # each spot
  puts "Fetching locations successfully done."
end
