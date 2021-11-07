# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'

Bundler.require(*Rails.groups)

module FastCinema
  class Application < Rails::Application
    config.load_defaults(6.1)

    config.autoload_paths += %W[
      #{config.root}/app/swagger/**/*.rb
      #{config.root}/app/services/**/*.rb
      #{config.root}/lib/**/*.rb
    ]

    config.generators do |g|
      g.helper = false
      g.system_tests = nil
      g.test_framework(:rspec,
                       routing_specs: false,
                       request_specs: true,
                       controller_specs: false)
    end

    config.api_only = true
  end
end
