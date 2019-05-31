# Needed so database isn't hit on install
Spree::Auth::Config.use_static_preferences!

# Required to work around sample data sending emails
Rails.application.config.action_mailer.raise_delivery_errors = false
