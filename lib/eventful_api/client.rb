require 'addressable/uri'
require 'multi_json'

module EventfulApi
  class Client
    API_URL = 'http://api.eventful.com'
    attr_reader :access_token, :oauth_consumer

    def initialize(params)
      @oauth_consumer = OAuth::Consumer.new(EventfulApi.config.consumer_key, EventfulApi.config.consumer_secret, :site => API_URL, :scheme => EventfulApi::SCHEME)
      @access_token = OAuth::AccessToken.new(oauth_consumer, params[:oauth_token], params[:oauth_secret])
    end

    def get(method, params)
      response = access_token.get get_path(method, params)

      MultiJson.load response.body
    end

    private

    def get_path(path, params)
      Addressable::URI.new(:path => json_path(path), :query_values => params).to_s
    end

    def json_path(path)
      "/json#{path}"
    end
  end
end
