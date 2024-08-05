class AiBotsController < ApplicationController
  require "faraday"

  def new
  end

  def create
    @response = get_ai_response(params[:query])
    render :new
  end

  private

  def get_ai_response(query)
    response = Faraday.post("https://api.openai.com/v1/chat/completions") do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Authorization"] = "Bearer #{ENV['OPENAI_API_KEY']}"
      req.body = {
        model:      "gpt-3.5-turbo",
        messages:   [
          { role: "system", content: "You are a helpful assistant." },
          { role: "user", content: query }
        ],
        max_tokens: 150
      }.to_json
    end
    JSON.parse(response.body)["choices"][0]["message"]["content"]
  end
end
