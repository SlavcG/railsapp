if Rails.env.production?
  Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
    :secret_key => ENV['STRIPE_SECRET_KEY']
  }
else
  Rails.configuration.stripe = {
    :publishable_key => 'pk_test_hovSLdH9ukwP0pKM2IGrtkcm',
    :secret_key => 'sk_test_Qe3eB7px5U5GfDdkaJwtesyf'
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
