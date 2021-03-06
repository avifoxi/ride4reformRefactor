require 'rails_helper'

RSpec.describe MailingAddress, :type => :model do
	
	let(:m_ad) { FactoryGirl.build(:mailing_address)}

	let(:donor_m) {FactoryGirl.build(:mailing_address, :donor)}

	it "has a valid factory" do
		expect(m_ad).to be_an_instance_of(MailingAddress)
	end

	it "validates user, rejects if not assigned" do 
		expect(m_ad.save).to be(false)	
	end

	it "validates user, and validates presence / numericality of addy fields" do 
		user = create(:user, :donor)
		m_ad.user = user
		expect(m_ad.save!).to eq(true)
	end

	it "assigns user's first addy as primary, subsequent not" do 
		user = donor_m.user
		donor_m.save
		expect(donor_m.users_primary).to eq(1)

		second_addy = FactoryGirl.build(:mailing_address)
		user.mailing_addresses << second_addy
		expect(m_ad.users_primary).to eq(0)
	end

	it 'validates zip against state correctly' do

		donor_m.update_attributes(state: 'CA', zip: '90035')
		expect(donor_m.valid?).to eq(true)
		donor_m.update_attributes(state: 'NY', zip: '11225')	
		expect(donor_m.valid?).to eq(true)

		donor_m.update_attributes(state: 'MI', zip: '11225')	
		expect(donor_m.valid?).to eq(false)
	end
end
