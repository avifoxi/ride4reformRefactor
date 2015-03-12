case Rails.env
when "development"
	Admin.create(username: 'AviAdmin', email:'admin@admin.com', password: 'adminpass')

	User.create(first_name: "Avi", last_name: "Rider", email: "a@a.com", password: 'password', title: User::TITLES.sample)

	RideYear.create(registration_fee: 600, registration_fee_early: 550, min_fundraising_goal: 2200, year: 2014, ride_start_date: "2014-03-15", ride_end_date: "2014-03-20", early_bird_cutoff: "2014-01-15")

	RideYear.create(registration_fee: 650, registration_fee_early: 600, min_fundraising_goal: 2500, year: 2015, ride_start_date: "2015-03-16", ride_end_date: "2015-03-21", early_bird_cutoff: "2015-01-15")

	RideYear.last.set_as_current

	users = []
	20.times do 
    users << User.create(title: User::TITLES.sample, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password)
  end

  goals = (2500..10000).to_a
  10.times do 
  	user = users.pop
  	rider = RiderYearRegistration.create(
  		user: user,
  		goal: goals.sample,
  		agree_to_terms: true,
  		ride_option: RiderYearRegistration::RIDE_OPTIONS.sample
  	)

  	rider.mailing_addresses.create(
  			line_1: Faker::Address.street_address,
  			city: Faker::Address.city,
  			zip: Faker::Address.zip_code,
  			state: Faker::Address.state)

  	rider.user.build_persistent_rider_profile(
  				primary_phone: '1234567890',
					birthdate: Faker::Date.between(20.years.ago, 60.years.ago).to_s,
					bio: Faker::Hacker.say_something_smart ,
					user: user
  	).save
  	
  end

when "production"
	Admin.create(username: 'AviAdmin', email:'admin@admin.com', password: 'adminpass')
	RideYear.create(registration_fee: 600, registration_fee_early: 550, min_fundraising_goal: 2200, year: 2014, ride_start_date: "2014-03-15", ride_end_date: "2014-03-20", early_bird_cutoff: "2014-01-15")

	RideYear.create(registration_fee: 650, registration_fee_early: 600, min_fundraising_goal: 2500, year: 2015, ride_start_date: "2015-03-16", ride_end_date: "2015-03-21", early_bird_cutoff: "2015-01-15")

	RideYear.last.set_as_current

end