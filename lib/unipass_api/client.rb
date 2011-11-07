module UnipassApi

  class Client

    attr_accessor :access_token, :refresh_token, :expires_at

    def initialize(options = {}, &block)
      @client_id     = options[:client_id]     || UnipassApi.options[:client_id]
      @client_secret = options[:client_secret] || UnipassApi.options[:client_secret]
      @site          = options[:site]          || UnipassApi.options[:site]
      @api_site      = options[:api_site]      || UnipassApi.options[:api_site]
      @authorize_url = options[:authorize_url] || UnipassApi.options[:authorize_url]
      @token_url     = options[:token_url]     || UnipassApi.options[:token_url]

      self.access_token  = options[:access_token]
      self.refresh_token = options[:refresh_token]
      self.expires_at    = options[:expires_at]
    end

    def expired?
      token.expired?
    end

    def refresh!
      new_token = token.refresh!
      self.access_token  = new_token.token
      self.refresh_token = new_token.refresh_token
      self.expires_at    = new_token.expires_at
      new_token
    end

    def request(verb, url, options = {})
      token.request(verb, url, options).parsed
    rescue OAuth2::Error => error
      case error.response.status
        when 404 then raise ResourceNotFound.new(error.response)
        when 422 then raise ResourceInvalid.new(error.response)
        else raise
      end
    end

    def get(url, options = {})
      request(:get, url, options)
    end

    def post(url, options = {})
      request(:post, url, options)
    end

    def client
      @client ||= ::OAuth2::Client.new(@client_id, @client_secret, {
          :site          => @api_site,
          :authorize_url => @authorize_url,
          :token_url     => @token_url
      })
    end

    private

    def token
      ::OAuth2::AccessToken.new(client, access_token, :refresh_token => refresh_token, :expires_at => expires_at, :mode => :query, :param_name => 'oauth_token')
    end

  end
end
