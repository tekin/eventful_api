require "eventful_api/version"

module EventfulApi
  @config = Struct.new(:consumer_key, :consumer_secret).new

  class << self
    attr_accessor :config

    def configure(&block)
      yield @config
    end
  end
end
