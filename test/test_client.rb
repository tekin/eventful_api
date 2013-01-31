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
        @client.access_token.expects(:get).with('/json/events/get?id=E0-001-053639493-9').returns('{["data"]}')

        @client.get('/events/get', :id => 'E0-001-053639493-9')
      end
    end
  end
end
