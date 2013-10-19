desc "Fetch Location's"
task :push_location => :environment do
  base_url = ENV['SCRAPER_BASE_URL']
  response = RestClient.post base_url + '/api/sessions.json', email: ENV['SCRAPER_EMAIL'], password: ENV['SCRAPER_PASSWORD']
  @cookies = response.cookies

  Location.all.each do |l|
    bl = {
      'title'       => l.name,
      'phone'       => l.phone_number,
      'webAddress'  => l.web_address,
      'email'       => '*',
      'contactName' => '*',
      'socialMedia' => l.social_media_address,
      'address'     => l.address,
      'latitude'    => l.lat,
      'longitude'   => l.lng
    }
    response = RestClient.post base_url + '/api/basic_listings.json', bl, { cookies: @cookies }
    puts JSON.parse(response)['id']
  end

  puts "Pushing locations successfully done."
  RestClient.delete base_url + '/api/sessions/123.json', cookies: @cookies
end
