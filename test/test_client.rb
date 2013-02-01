require 'test_helper'

class TestEventfulApi < MiniTest::Unit::TestCase
  def setup
    EventfulApi.configure do |config|
      config.consumer_key = 'key'
      config.consumer_secret = 'secret'
      config.app_key = 'app_key'
    end
  end

  describe EventfulApi::Client do
    before do
      @client = EventfulApi::Client.new(:oauth_token => 'client_key', :oauth_secret => 'client_secret')
    end

    it 'has a oauth consumer for accessing the Eventful API' do
      consumer = @client.oauth_consumer

      assert consumer.is_a?(OAuth::Consumer)
      assert_equal EventfulApi::Client::API_URL, consumer.site
      assert_equal EventfulApi.consumer_key, consumer.key
      assert_equal EventfulApi.consumer_secret, consumer.secret
    end

    it 'has an ouath access token' do
      access_token = @client.access_token

      assert access_token.is_a?(OAuth::AccessToken)
      assert_equal 'client_key', access_token.token
      assert_equal 'client_secret', access_token.secret
      assert_equal @client.oauth_consumer, access_token.consumer
    end

    describe 'making a GET API call with parameters' do
      it 'transforms the request and delegates the call through the access token' do
        @client.access_token.expects(:get).with("/json/events/get?app_key=#{EventfulApi.app_key}&id=E0-001-053639493-9").returns(mock_response)
        @client.get('/events/get', :id => 'E0-001-053639493-9')
      end

      it 'returns a hash representation of the response body' do
        @client.access_token.expects(:get).with("/json/events/get?app_key=#{EventfulApi.app_key}&id=E0-001-054172192-4").returns(mock_response)
        response = @client.get('/events/get', :id => 'E0-001-054172192-4')

        assert_equal ({'foo' => 'bar'}), response
      end
    end

    describe 'making a POST API call with parameters' do
      it 'transforms the request and delegates the call through the access token' do
        @client.access_token.expects(:post).with('/json/events/new', {:id => 'E0-001-053639493-9', :app_key => EventfulApi.app_key}).returns(mock_response)
        response = @client.post('/events/new', :id => 'E0-001-053639493-9')
      end

      it 'returns a hash representation of the response body' do
        @client.access_token.expects(:post).with('/json/events/new', {:id => 'E0-001-054172192-4', :app_key => EventfulApi.app_key}).returns(mock_response)
        response = @client.post('/events/new', :id => 'E0-001-054172192-4')

        assert_equal ({'foo' => 'bar'}), response
      end
    end

    def mock_response
      Struct.new(:body).new('{"foo": "bar"}')
    end
  end
end
