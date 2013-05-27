# EventfulApi

[![Build Status](https://api.travis-ci.org/tekin/eventful_api.png)](http://travis-ci.org/tekin/eventful_api)

A Ruby library for accessing the eventful.com API. It supports
their new OAuth authentication method.

## Installation

    gem install eventful_api

## Configuration and usage

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

```ruby
  client = EventfulApi::Client.new(:oauth_token => 'token', :oauth_token_secret => 'token secret')

  responsh_hash = client.post('/events/new', event_param_hash)
  response_hash = client.get('/events/get', {:id => 'E0-001-053639493-9'})
```

EventfulApi makes requests to Eventful's JSON interface, returning the Hash equivalent of the JSON responses.

## OAuth authentication

You are free to acquire OAuth authorization from your users using your own process. However, EventfulApi does provide a
convenient facade for generating both request tokens and access tokens.

### Step 1. Requesting a token and redirect the user

```ruby
  request_token = EventfulApi.get_request_token(:oauth_callback => 'http://example.com/callback')
  # store the request token and secret for later use and redirect the user
  session[:request_token] = request_token.token
  session[:request_secret] = request_token.secret
  redirect_to token.redirect_url
```

### Step 2. Acquiring an access token during the callback

```ruby
  # Reconstruct the request token using the token and secret saved in the session
  request_token = OAuth::RequstToken.new(EventfulApi.oauth_consumer, session[:request_token], session[:request_secret])
  # Get an access token from Eventful using the oauth_verifier param
  access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # You now have a verified token and secret ready to create a client
  client = EventfulApi::Client.new(:oauth_token => access_token.token, :oauth_secret => access_token.secret)
```

License
-------
Released under the MIT License. See the [LICENSE][license] file for further details.

[license]: LICENSE.md
