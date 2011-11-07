# Unipass API #

This is wrapper for Unipass REST API. In order to use it, you will need to get unipas access token (see [omniauth-unipass][https://github.com/tjeden/omniauth-unipass])

# Installation #

Add to your `Gemfile` following line:

    gem 'unipass_api'

Create `config/initializers/unipass_api.rb` with configuration options:

    UnipassApi.configure do |config|
      config.client_id = 'some_client_id'
      config.client_secret = 'some_client_secret'
      config.site = 'some_site'
      config.api_site = 'some_api_site'
      config.authorize_url = 'some_authorize_url'
      config.token_url = 'some_token_url'
    end

And you are ready to go.

# Usage #

Assuming you are using omniauth, and you are succesfull logged in into unipass, you can create client in your application controller:

    def unipass_api(force_refresh_token = false)
      @unipass_api ||= UnipassApi::Client.new(
        :access_token  => session[:access_token],
        :expires_at    => session[:access_token_expires_at],
        :refresh_token => session[:refresh_token]
        )
      if @unipass_api.expired? || force_refresh_token
        @unipass_api.refresh!
        session[:access_token]            = @unipass_api.access_token
        session[:access_token_expires_at] = @unipass_api.expires_at
        session[:refresh_token]           = @unipass_api.refresh_token
      end
      @unipass_api
    end

And then you can just use it as follows: 

    unipass_api.post('groups', :params => {:name => 'group_name'})

## Adding property ##

    @property = begin
      unipass_api.post("me/properties/weight", :params => {:value => '57  kg'})
    rescue UnipassApi::ResourceInvalid => error
      @errors = error.response.parsed
      render :show and return
    end 

## Showing property ##

    @property = begin
      unipass_api.get("me/properties/#{key}")
    rescue UnipassApi::ResourceNotFound
      nil
    end 



