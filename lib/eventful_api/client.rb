require 'addressable/uri'

module EventfulApi
  class Client
    attr_reader :access_token

    def initialize(params)
      @access_token = OAuth::AccessToken.new(EventfulApi.oauth_consumer, params[:oauth_token], params[:oauth_secret])
    end

    def get(method, params)
      access_token.get get_path(method, params)
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
