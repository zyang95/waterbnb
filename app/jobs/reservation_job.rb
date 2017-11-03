class ReservationJob < ApplicationJob
	queue_as :default

  def perform(user, host, listing)
     ReservationMailer.booking_email(user, host, listing).deliver_now
  end
end
