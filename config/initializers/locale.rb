Rails.application.configure do
  config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
  config.i18n.available_locales = [:ja]
  config.i18n.default_locale = :ja
end
