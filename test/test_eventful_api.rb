require 'test_helper'

class TestEventfulApi < MiniTest::Unit::TestCase

  describe EventfulApi do
    it 'is configurable' do
      EventfulApi.configure do |config|
        config.consumer_key = 'key'
        config.consumer_secret = 'secret'
      end

      assert_equal 'key', EventfulApi.config.consumer_key
      assert_equal 'secret', EventfulApi.config.consumer_secret
    end

    describe 'once configured' do
      before do
        EventfulApi.configure do |config|
          config.consumer_key = 'key'
          config.consumer_secret = 'secret'
        end
      end

      it 'has an OAuth::Consumer instance' do
        consumer = EventfulApi.oauth_consumer

        assert consumer.is_a?(OAuth::Consumer)
        assert_equal 'secret', consumer.secret
        assert_equal 'key', consumer.key
        assert_equal EventfulApi::SITE_URL, consumer.site
        assert_equal EventfulApi::SCHEME, consumer.scheme
      end
    end
  end
end
