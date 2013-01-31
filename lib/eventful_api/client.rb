module EventfulApi
  class Client
    attr_reader :access_token

    def initialize(params)
      @access_token = OAuth::AccessToken.new(EventfulApi.oauth_consumer, params[:oauth_token], params[:oauth_secret])
    end
  end
end
