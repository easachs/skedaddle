# frozen_string_literal: true

class GptService
  KEY = ENV.fetch('OPENAI_API_KEY', nil)

  class << self
    def summary(itinerary)
      return if itinerary.prompt.blank?

      Rails.cache.fetch("gpt/#{current_user.id}/#{itinerary.id}", expires_in: 1.hour) do
        response = fetch_gpt(itinerary.prompt)
        JSON.parse(response.body, symbolize_names: true)
      end
    end

    private

    def fetch_gpt(prompt)
      conn.post('v1/chat/completions') do |f|
        f.body = payload(prompt)
      end
    end

    def payload(prompt)
      return if prompt.blank?

      { model: 'gpt-3.5-turbo',
        messages: [
          { role: 'system', content: 'You are a helpful assistant.' },
          { role: 'user', content: 'Hello!' }
        ],
        temperature: 0.5,
        max_tokens: 500 }.to_json
    end

    def conn
      Faraday.new(url: 'https://api.openai.com') do |f|
        f.params['appid'] = KEY
        f.headers['Authorization']  = "Bearer #{ENV.fetch('OPENAI_API_KEY', nil)}"
        f.headers['Content-Type']   = 'application/json'
      end
    end

    def role
      "You're a travel planner specializing in adventurous, eco-friendly trips for young explorers. Craft balanced,
      budget-friendly itineraries featuring historic sites, outdoor activities, and landmarks. Provide brief daily plans
      with themed titles and concise morning, afternoon, and evening suggestions in one sentence each. Maintain a
      cheerful, casual tone with occasional humor in summaries, and be straightforward in day-to-day guides. Avoid
      clarifying questions and emojis."
    end
  end
end
