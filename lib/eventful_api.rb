require 'forwardable'
require 'oauth'
require 'eventful_api/client'
require 'eventful_api/version'

module EventfulApi
  SITE_URL = 'http://eventful.com'
  SCHEME = :query_string

  @config = Struct.new(:consumer_key, :consumer_secret, :app_key).new

  class << self
    extend Forwardable

    def_delegators :@config, :consumer_key, :consumer_secret, :app_key

    def configure(&block)
      yield @config
    end

    def oauth_consumer
      @consumer ||= OAuth::Consumer.new(consumer_key, consumer_secret, :site => SITE_URL, :scheme => SCHEME)
    end

    def get_request_token(options)
      oauth_consumer.get_request_token(options)
    end
  end
end
