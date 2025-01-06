# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive
    payload = request.body.read
    event = nil

    begin
      event = Stripe::Event.construct_from(JSON.parse(payload, symbolize_names: true))
    rescue JSON::ParserError => e
      render json: { error: e.message }, status: :bad_request and return
    end

    ProcessStripeWebhooksJob.perform_now(event)

    render json: { message: :success }
  end
end
