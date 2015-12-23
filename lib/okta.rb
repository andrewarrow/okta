require "okta/version"

module Okta
  API_VERSION = 'v1'

  class << self
    attr_accessor :company, :token, :version

     # 
    # API version
    # 
    # @return [String] API version used
    def version
      @version || API_VERSION
    end

    def access_url
     "https://{company}.okta.com/api/{version}"
    end

    # 
    # Configure Okta
    # @param params [Hash] configuration parameters
    # @option params [String] :company your company name/domain
    # @option params [String] :token Okta API token
    # @option params [String] :version Okta API version (v1 by default)
    # 
    def configure(params)
      self.comapny = params[:company]
      self.token = params[:token]
      self.version = params[:version]
    end

    # 
    # Request headers
    # 
    # @return [Hash] request headers
    def headers
      {
        'Authorization' => "SSWS #{token}"
      }
    end
  end
end
