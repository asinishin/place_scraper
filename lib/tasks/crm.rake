desc "Set users state for pipeline"
namespace :crm do
  task :contacts => :environment do
    puts "Processing..."
    
    agent = Crm::ContactApi.new
    User.all.each do |user|
      agent.add(user.id)
    end

    puts "Complete."
  end

  task :listings => :environment do
    puts "Processing..."
    
    agent = Crm::ListingApi.new
    HostingDescription.all.each do |hd|
      if hd.hosting_status_id == 6 # Published
	state = 'L: Active'
      elsif hd.hosting_status_id == 5 # Complete
	state = 'L: Hidden'
      else
	state = 'L: Incomplete'
      end

      agent.add(hd.id, state)
    end

    puts "Complete."
  end

  task :requests => :environment do
    puts "Processing..."
    
    agent = Crm::RequestApi.new
    StorageRequest.all.each do |r|
      if [4, 5, 8].include?(r.request_status_id) # Direct Booking, Booking, Booking Confimed
	state = 'R: Booking'
      elsif r.request_status_id == 9 # Booking Deleted
	state = 'R: Dropped booking'
      elsif r.request_status_id == 6 # Renting
	state = 'R: Rented'
      elsif r.request_status_id == 7 # Contract Closed
	state = 'Closed Lost'
      elsif r.request_status_id == 3 # Declined
	state = 'R: Declined'
      else
	state = 'R: Active'
      end

      agent.add(r.id, state)
    end

    puts "Complete."
  end

  task :corresponding_listings => :environment do
    puts "Processing..."
    
    agent = Crm::RequestApi.new
    StorageRequest.all.each do |r|
      agent.update_corresponding_listing(r.id)
    end

    puts "Complete."
  end

  task :squirrel_requests => :environment do
    puts "Processing..."
    
    agent = Crm::RequestApi.new
    StorageRequest.all.each do |r|
      agent.update_squirrel_request(r.id)
    end

    puts "Complete."
  end

  task :contacts_time => :environment do
    puts "Processing..."
    
    agent = Crm::ContactApi.new
    User.all.each do |u|
      agent.update_signed_up_and_last_login(u.id)
    end

    puts "Complete."
  end

  task :contacts_sis => :environment do
    puts "Processing..."
    
    agent = Crm::ContactApi.new
    User.all.each do |u|
      agent.update_sis_fields(u.id)
    end

    puts "Complete."
  end
end
