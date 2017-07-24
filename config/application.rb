require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module SouvenirShop
  class Application < Rails::Application
    config.load_defaults 5.1
    config.i18n.default_locale = :vn
    config.i18n.available_locales = [:vn, :en]
  end
end
