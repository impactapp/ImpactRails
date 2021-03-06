class DeleteStripeCardService < Aldous::Service
	require "stripe"
	Stripe.api_key = Rails.application.secrets.stripe_api_key
	def initialize(user,stripe_card_id)
		@user = user
		@stripe_card_id = stripe_card_id
	end

	def perform
		begin 
			card = Stripe::Customer.retrieve(@user.stripe_customer_id).sources.data
			card_array = Array(card)
			if card_array.count == 1
				@user.update_attribute(:has_credit_card,false)
			end
			customer = Stripe::Customer.retrieve(@user.stripe_customer_id)
			response = customer.sources.retrieve(@stripe_card_id).delete
			Result::Success.new(result: response)
		rescue Exception => errors
			puts errors.message
			Result::Failure.new(errors: errors.message)
		end
	end

end