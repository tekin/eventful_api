require 'test_helper'

class TestEventfulApi < MiniTest::Unit::TestCase

  describe EventfulApi do
    before do
      EventfulApi.configure do |config|
        config.consumer_key = 'key'
        config.consumer_secret = 'secret'
        config.app_key = 'app_key'
      end
    end

    it 'has a consumer key' do
      assert_equal 'key', EventfulApi.consumer_key
    end

    it 'has a consumer secret' do
      assert_equal 'secret', EventfulApi.consumer_secret
    end

    it 'has an app key' do
      assert_equal 'app_key', EventfulApi.app_key
    end

    it 'has an oauth consumer' do
      consumer = EventfulApi.oauth_consumer

      assert consumer.is_a?(OAuth::Consumer)
      assert_equal EventfulApi.consumer_key,    consumer.key
      assert_equal EventfulApi.consumer_secret, consumer.secret
      assert_equal EventfulApi::SITE_URL,       consumer.site
      assert_equal EventfulApi::SCHEME,         consumer.scheme
    end

    it 'delegates request token generation to its oauth consumer' do
      options = { :callback_url => 'http://example.com/callback'}
      EventfulApi.oauth_consumer.expects(:get_request_token).with(options).returns('token')

      assert_equal 'token', EventfulApi.get_request_token(options)
    end
  end
end
