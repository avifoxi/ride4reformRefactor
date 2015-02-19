class RiderYearRegistrationsController < ApplicationController
	skip_before_action :authenticate_admin!
	# skip_before_action :authenticate_user!, only: [:new, :create]

	def new 
		## assume never registered before - brand new ... and deal with alternative scenario once this is built
		@ryr = RiderYearRegistration.new
	end

	def create 
		@ryr = RiderYearRegistration.new(user: current_user)
		if @ryr.update_attributes(ryr_params)
			redirect_to rider_year_registrations_agree_to_terms_path(rider_year_registration: @ryr)
		else
			@errors = @ryr.errors
			render :new
		end
	end

	def new_agree_to_terms
		@ryr = RiderYearRegistration.find(params[:rider_year_registration])
	end

	def create_agree_to_terms
		@ryr = RiderYearRegistration.find(params[:ryr_id])
		if @ryr.update_attributes(full_params)
			redirect_to rider_year_registrations_persistent_rider_profile_path(rider_year_registration: @ryr)
		else
			@errors = @ryr.errors
			render :new_agree_to_terms
		end
	end

	def new_persistent_rider_profile
		@ryr = RiderYearRegistration.find(params[:rider_year_registration])
		@ryr.user.build_persistent_rider_profile(user: @ryr.user)
	end

	def create_persistent_rider_profile

		@ryr = RiderYearRegistration.find(params[:ryr_id])
		prp = @ryr.user.build_persistent_rider_profile(user: @ryr.user)

		if prp.update_attributes(prp_params)
			redirect_to rider_year_registrations_mailing_address_path(rider_year_registration: @ryr)
		else
			@errors = prp.errors
			render :new_persistent_rider_profile
		end

	end

	def new_mailing_address
		@ryr = RiderYearRegistration.find(params[:rider_year_registration])
		@ryr.mailing_addresses.build
	end

	def create_mailing_address
		p '$'*80
		p 'malin addinges params'
		p "#{mailing_addesses_params}"
		p '$'*80

		@ryr = RiderYearRegistration.find(params[:ryr_id])
		m_a = @ryr.mailing_addresses.build(user: @ryr.user)

		if m_a.update_attributes(mailing_addesses_params)
			p '$'*80
			p 'mailing addy saved to db'
			p "#{m_a.inspect}"
			p '$'*80
		else
			@errors = m_a.errors
			render :new_mailing_address
		end

		
	end

	

	def new_pay_reg_fee

	end

	def create_registrations_pay_fee

	end

	private 

	def full_params
    params.require(:rider_year_registration).permit(:ride_option, :goal, :agree_to_terms,
    	:mailing_addresses_attributes => [
    			:line_1, :line_2, :city, :state, :zip
    		],
    	:persistent_rider_profile_attributes => [
    			:primary_phone, :secondary_phone, :photo_upload, :birthdate, :bio
    		] )
  end

  def mailing_addesses_params
  	full_params['mailing_addresses_attributes']['0']
  end

  def prp_params
  	full_params['persistent_rider_profile_attributes']
  end

  def ryr_params 
  	{
  		ride_option: full_params[:ride_option],
  		goal: full_params[:goal]
  	} 	
  end

end
