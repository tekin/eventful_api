EventfulApi
===========

Description
-----------

A Ruby library for accessing the eventful.com API. It supports
their new OAuth authentication method.

Installation
------------
    gem install eventful_api

Configuration and usage
----------------------

The Eventful API requires authentication via [OAuth 1.0](http://tools.ietf.org/html/rfc5849) to access resources on
behalf of Eventful users. You can register your application at
[http://api.eventful.com/keys](http://api.eventful.com/keys). Once registered, you'll need to generate your
OAuth consumer and secret.

Configure `EventfulApi` with your application key, OAuth consumer key and your
OAuth consumer secret:

```ruby
EventfulApi.configure do |config|
  config.application_key = YOUR_APPLICATION_KEY
  config.consumer_key = YOUR_CONSUMER_KEY
  config.consumer_secret = YOUR_CONSUMER_SECRET
end
```

You can make requests on behalf of a user once you have acquired their OAuth
access token/secret pair by instantiating an `EventfulApi::Client`:

````ruby
client = EventfulApi::Client.new(:oauth_token => 'token', :oauth_token_secret => 'token secret')

client.post('/events/new', event_params)
client.get('/events/get', {:id => 'E0-001-053639493-9'})
```

Authentication
--------------

TO FOLLOW...

License
-------
Released under the MIT License.  See the [LICENSE][license] file for further details.

[license]: https://github.com/tekin/eventful_api/blob/master/LICENSE.md
