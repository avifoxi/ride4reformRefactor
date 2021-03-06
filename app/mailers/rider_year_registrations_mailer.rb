class RiderYearRegistrationsMailer < ApplicationMailer
  default from: "rider_year_registrations@ride4reform.com"

  def successful_registration_welcome_rider(ryr)
  	@ryr = ryr
  	@year = RideYear.current.year
  	@receipt  = @ryr.registration_payment_receipt
  	# @receipt = @donation.receipt
  	# @donor = @donation.user
  	# @rider = @donation.rider
  	@prp = @ryr.persistent_rider_profile
  	mail(to: @ryr.email, subject: "Receipt for donation to #{@ryr.full_name}")
  end

  def user_register_for_ride_before_payment(ryr)
    @ryr = ryr
    @year = RideYear.current.year
    @receipt  = @ryr.registration_payment_receipt
    # @receipt = @donation.receipt
    # @donor = @donation.user
    # @rider = @donation.rider
    @prp = @ryr.persistent_rider_profile
    mail(to: @ryr.email, subject: "Link to your fundraising profile")
  end
end
