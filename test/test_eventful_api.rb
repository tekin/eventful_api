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
  end
end
