require 'oauth'
require 'eventful_api/client'
require 'eventful_api/version'

module EventfulApi
  SITE_URL = 'http://eventful.com'
  SCHEME = :query_string

  @config = Struct.new(:consumer_key, :consumer_secret).new

  class << self
    attr_accessor :config

    def configure(&block)
      yield @config
    end

    def oauth_consumer
      @consumer ||= OAuth::Consumer.new(config.consumer_key, config.consumer_secret, :site => SITE_URL, :scheme => SCHEME)
    end
  end
end
