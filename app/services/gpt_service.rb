# frozen_string_literal: true

class GptService
  def initialize(key = nil)
    @key = key
  end

  def summary(itinerary)
    return if itinerary&.prompt.blank?

    response = JSON.parse(fetch_gpt(itinerary.prompt).body, symbolize_names: true)
    parsed_response = response&.dig(:choices, 0, :message, :content)
    formatted(parsed_response) if parsed_response
  end

  private

  def fetch_gpt(prompt)
    conn.post('v1/chat/completions') do |route|
      route.body = { model: 'gpt-3.5-turbo',
                     messages: [{ role: 'system', content: role },
                                { role: 'user', content: prompt }],
                     temperature: 0.5 }.to_json
    end
  end

  def formatted(response)
    response.split('\n')
            .map { |line| "<p>#{line}</p>" }
            .reject { |line| line == '<p></p>' }
            .join
            .delete('*')
            .gsub(%r{(<p>Day \d+:.*?</p>)}, '\1<br>')
            .gsub(%r{(<p>Evening:.*?</p>)}, '\1<br>')
            .gsub(/<p>([^:]+):/, '<p><strong>\1:</strong>')
            .sub(/<br>\z/, '')
  end

  def conn
    Faraday.new(url: 'https://api.openai.com') do |route|
      route.headers['Authorization'] = "Bearer #{@key}"
      route.headers['Content-Type']  = 'application/json'
    end
  end

  def role
    "You're a travel planner specializing in adventurous, eco-friendly trips for young explorers.
    Craft balanced, budget-friendly itineraries featuring historic sites, outdoor activities, and landmarks.
    Provide daily plans with themed titles and concise morning/afternoon/evening suggestions in one sentence each.
    Maintain a cheerful, casual tone with occasional humor in summaries, and be straightforward in day-to-day guides.
    Avoid clarifying questions and emojis."
  end
end
