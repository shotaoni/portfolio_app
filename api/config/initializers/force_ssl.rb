# frozen_string_literal: true

Rails.application.routes.default_url_options[:protocol] = 'https' if Rails.application.config.force_ssl
