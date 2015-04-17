class DonationAlertRiderWorker
  include Sidekiq::Worker

  def perform(donation_id)
    donation = Donation.find(donation_id)

    logger.info "Things are happening."
    logger.debug "Here's some info: #{donation.inspect}"
		DonationMailer.successful_donation_alert_rider(donation).deliver  
	end
end