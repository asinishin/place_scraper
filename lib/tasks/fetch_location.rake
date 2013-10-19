desc "Fetch Location's"
task :fetch_location => :environment do
  Geocoder.search(ENV["city_name"]).each do |g|
    ::GOOGLE_PLACES.spots(
      g.data["geometry"]["location"]["lat"],
      g.data["geometry"]["location"]["lng"],
      radius: 50000,
      types: "storage",
      keyword: "self storage",
      multipage: true).each do |gp|
        details = ::GOOGLE_PLACES.spot(gp.reference)
        Location.create(
          name: gp.name[0..49],
          address: (gp.formatted_address || gp.vicinity),
          lat: gp.lat, lng: gp.lng,
          web_address:  (details.website || '*'),
          phone_number: (details.formatted_phone_number || '-'),
          social_media_address: (details.url || '*')
        )
    end # each spot
  end # each city
  puts "Fetching locations successfully done."
end
