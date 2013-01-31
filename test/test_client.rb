require 'test_helper'

class TestEventfulApi < MiniTest::Unit::TestCase

  describe EventfulApi::Client do
    before do
      @client = EventfulApi::Client.new(:oauth_token => 'key', :oauth_secret => 'secret')
    end

    it 'has an OAuth::AccessToken' do
      access_token = @client.access_token

      assert access_token.is_a?(OAuth::AccessToken)
      assert_equal 'key', access_token.token
      assert_equal 'secret', access_token.secret
      assert_equal EventfulApi.oauth_consumer, access_token.consumer
    end

    describe 'making a GET API call with parameters' do

      it 'transform and delegate the request to the access token' do
        @client.access_token.expects(:get).with('/json/events/get?id=E0-001-053639493-9').returns(mock_response)
        @client.get('/events/get', :id => 'E0-001-053639493-9')
      end

      it 'returns a hash representation of the response body' do
        @client.access_token.expects(:get).with('/json/events/get?id=V0-001-006696043-3').returns(mock_response)
        response = @client.get('/events/get', :id => 'V0-001-006696043-3')

        assert_equal ({'foo' => 'bar'}), response
      end
    end

    def mock_response
      Struct.new(:body).new('{"foo": "bar"}')
    end
  end
end
