# frozen_string_literal: true

class ProcessStripeWebhooksJob < ApplicationJob
  queue_as :default

  def perform(event)
    case event.type
    when 'checkout.session.completed'
      checkout_completed(event.data.object)
    end
  end

  private

  def checkout_completed(session)
    user = User.find_by(email: session.customer_email || session.customer_details&.email)
    return unless user

    Payment.create!(user:, payment_id: session.id, amount: session.amount_total,
                    payment_type: session.mode == 'subscription' ? 'subscription' : 'onetime')

    if session.mode == 'subscription'
      user.update!(subscribed: true)
    elsif session.mode == 'payment'
      user.add_credits(10)
    end
  end
end
