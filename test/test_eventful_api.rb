require 'rubygems'
require 'minitest/autorun'

$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require 'eventful_api'

class TestEventfulApi < MiniTest::Unit::TestCase

  describe EventfulApi do
    it 'is configurable' do
      EventfulApi.configure do |config|
        config.consumer_key = 'some key'
        config.consumer_secret = 'some secret'
      end

      assert_equal 'some key', EventfulApi.config.consumer_key
      assert_equal 'some secret', EventfulApi.config.consumer_secret
    end

    describe 'once configured' do
      before do
        EventfulApi.configure do |config|
          config.consumer_key = 'key'
          config.consumer_secret = 'secret'
        end
      end

      it 'returns a configured OAuth::Consumer' do
        consumer = EventfulApi.oauth_consumer

        assert_equal 'secret', consumer.secret
        assert_equal 'key', consumer.key
        assert_equal EventfulApi::SITE_URL, consumer.site
        assert_equal EventfulApi::SCHEME, consumer.scheme
      end
    end
  end
end
