module UnipassApi
  # Defines constants and methods related to configuration
  module Config
    # An array of valid keys in the options hash when configuring a {Twitter::Client}
    VALID_OPTIONS_KEYS = [
      :client_id,
      :client_secret,
      :site,
      :api_site,
      :authorize_url,
      :token_url
    ]

    attr_accessor *VALID_OPTIONS_KEYS
    
    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end

  end
end
