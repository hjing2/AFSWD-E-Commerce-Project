# config/initializers/stripe.rb

Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.dig(:stripe, :publishable_key),
  secret_key: Rails.application.credentials.dig(:stripe, :secret_key)
}

Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

Rails.logger.debug "Stripe publishable key: #{Rails.configuration.stripe[:publishable_key]}"
Rails.logger.debug "Stripe secret key: #{Rails.configuration.stripe[:secret_key]}"
