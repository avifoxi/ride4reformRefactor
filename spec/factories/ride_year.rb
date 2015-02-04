FactoryGirl.define do
  factory :ride_year do

		trait :old do
	    registration_fee_early 550
	    registration_fee 600
			min_fundraising_goal 2200
			year 2014
			ride_start_date "2014-03-16"
			ride_end_date "2014-03-21"
			early_bird_cutoff "2014-01-15"
	  end

    trait :current do
    	registration_fee_early 600
	    registration_fee 650
			min_fundraising_goal 2500
			year 2015
			ride_start_date "2015-03-16"
			ride_end_date "2015-03-21"
			early_bird_cutoff "2014-01-15"
	  end

  end
end