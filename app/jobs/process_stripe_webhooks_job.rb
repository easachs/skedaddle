# frozen_string_literal: true

class ProcessStripeWebhooksJob < ApplicationJob
  queue_as :default

  def perform(event)
    case event.type
    when 'checkout.session.completed'
      checkout_completed(event.data.object)
    when 'customer.subscription.updated'
      subscription_updated(event.data.object)
    when 'customer.subscription.deleted'
      subscription_ended(event.data.object)
    end
  end

  private

  def checkout_completed(session)
    user = User.find_by(email: session.customer_email || session.customer_details&.email)
    return unless user

    Payment.create!(user:, payment_id: session.id, amount: session.amount_total,
                    payment_type: session.mode == 'subscription' ? 'subscription' : 'onetime')

    if session.mode == 'subscription'
      user.update!(subscribed: true, subscription_id: session.subscription)
    elsif session.mode == 'payment'
      user.add_credits(10)
    end
  end

  def subscription_updated(subscription)
    user = User.find_by(subscription_id: subscription.id)
    return unless user

    if subscription.cancel_at_period_end
      user.update!(canceled: true)
    else
      user.update!(subscribed: true, canceled: false)
    end
  end

  def subscription_ended(subscription)
    user = User.find_by(subscription_id: subscription.id)
    return unless user

    user.update!(subscribed: false, canceled: false)
  end
end
