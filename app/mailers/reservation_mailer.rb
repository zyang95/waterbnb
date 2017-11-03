class ReservationMailer < ApplicationMailer

	default from: 'waterbnb95@gmail.com'
	
	def booking_email(user, host, listing)
  		@user = user
  		@host = host
  		@listing = listing
    	mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  	end
end
