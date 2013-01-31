module EventfulApi
  class Client
    attr_reader :access_token

    def initialize(params)
      @access_token = OAuth::AccessToken.new(EventfulApi.oauth_consumer, params[:oauth_token], params[:oauth_secret])
    end

    def get(method, params)
      access_token.get('/events/get?id=E0-001-053639493-9')
    end
  end
end
