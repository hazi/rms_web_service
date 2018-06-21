# frozen_string_literal: true

require "base64"

module RmsWebService
  class Configuration
    attr_accessor :service_secret, :license_key

    def initialize(args={})
      @service_secret = args[:service_secret]
      @license_key = args[:license_key]
    end

    def encoded_keys
      raise RmsWebService::ParameterError, "service_secret is required" unless service_secret.present?
        raise RmsWebService::ParameterError, "license_key is required" unless license_key.present?

        "ESA " + Base64.strict_encode64(service_secret + ":" + license_key)
    end
  end
end
