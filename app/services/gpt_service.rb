# frozen_string_literal: true

class GptService
  def initialize(key = nil)
    @key = key
  end

  def plan(itinerary) = format_response(plan_role, itinerary&.prompt)
  def info(city) = format_response(info_role, city)
  def blogpost(city) = format_response(blogpost_role, city)

  private

  def format_response(role, input)
    return if input.blank?

    response = JSON.parse(fetch_gpt(role, input).body, symbolize_names: true)
    parsed_response = response&.dig(:choices, 0, :message, :content)
    formatted(parsed_response) if parsed_response
  end

  def fetch_gpt(role, prompt)
    conn.post('v1/chat/completions') do |route|
      route.body = { model: 'gpt-3.5-turbo',
                     messages: [{ role: 'system', content: role },
                                { role: 'user', content: prompt }],
                     temperature: 0.5 }.to_json
    end
  end

  def formatted(response)
    renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(response)
  end

  def conn
    Faraday.new(url: 'https://api.openai.com') do |route|
      route.headers['Authorization'] = "Bearer #{@key}"
      route.headers['Content-Type']  = 'application/json'
    end
  end

  def plan_role
    "You're a travel planner specializing in adventurous, eco-friendly trips for young explorers.
    Craft balanced, budget-friendly itineraries featuring historic sites, outdoor activities, and landmarks.
    Start with a brief, light-hearted introductory summary/description about the location provided.
    Provide daily plans with themed titles and concise morning/afternoon/evening suggestions.
    Finish with a short conclusion about the itinerary you've created.
    Maintain a cheerful, casual tone with occasional humor, and be straightforward in day-to-day guides.
    Avoid clarifying questions and emojis."
  end

  def info_role
    "Summarize the city provided with four headings/sections: History, Culture, Activities, and Food.
    Format the summary in markdown, and for each section, use third-level headings (###).
    Write a detailed paragraph for each in an informative, engaging tone, suitable for a first-time reader."
  end

  def blogpost_role
    "You're a creative travel blogger known for captivating storytelling and inspiring readers to explore.
    Write a detailed, engaging, and unique travel blog post about the city provided.
    Start with a vibrant introduction highlighting the city's unique charm and why it's worth visiting.
    Explore topics like local history and culture, iconic landmarks and hidden gems, popular activities
    and experiences, food and nightlife, and practical tips for travelers.
    Use vivid language and include fun anecdotes or surprising facts about the city.
    Maintain an enthusiastic tone that evokes wanderlust.
    Conclude with a memorable takeaway or a call-to-action encouraging readers to visit the city."
  end
end
