# EventfulApi

## Description

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

client.post('/events/new', event_params)
response_hash = client.get('/events/get', {:id => 'E0-001-053639493-9'})
```

EventfulApi makes requests to the Eventful JSON interface and clients return the Hash equivalent of the JSON response.

## OAuth authentication

You are free to acquire OAuth authorization from your users using your own process. However, EventfulApi does provide a convenient facade for generating both request tokens and access tokens.

### Step 1. Requesting a token and redirect the user

```ruby
request_token = EventfulApi.get_request_token(:oauth_callback => 'http://example.com/callback')
# store the request_token for later use and redirect the user
session[:request_token] = request_token
redirect_to request_token.authorize_url
```

The `OAuth::RequestToken` class is stable enough and the object instance transient enough that you are safe to store it in the session so that it is available to you when during the callback. Alternatively, you can store just the token and secret in the session:

```ruby
session[:request_token] = request_token.token
session[:request_secret] = request_token.secret
redirect_to token.redirect_url
```

Then it's a case of recreating the `OAuth::RequestToken` during the callback:

```ruby
request_token = EventfulApi::OAuth::RequstToken.new(session[:request_token], session[:request_secret])
```

### Step 2. Acquiring an access token during the callback

```ruby
access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier]);
# We can now use the user's verified token and secret to create a client:
client = EventfulApi::Client.new(:oauth_token => access_token.token, :oauth_secret => access_token.secret)
```

License
-------
Released under the MIT License.  See the [LICENSE][license] file for further details.

[license]: LICENSE.md
