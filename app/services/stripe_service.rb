# frozen_string_literal: true

class StripeService
  class << self
    def checkout(email:, mode:, root_url:)
      Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        mode:,
        line_items: [{ price: price_id(mode), quantity: 1 }],
        success_url: "#{root_url}?success=true",
        cancel_url: "#{root_url}?canceled=true",
        customer_email: email
      )
    end

    def price_id(mode)
      if mode == 'subscription'
        ENV.fetch('STRIPE_SUBSCRIPTION_ID', nil)
      else
        ENV.fetch('STRIPE_CREDITS_ID', nil)
      end
    end
  end
end
