require 'okta/version'
require 'okta/user'
require 'okta/group'
require 'net/http'
require 'json'

module Okta
  API_VERSION = 'v1'

  class << self
    attr_accessor :company, :token
    attr_writer :version

    # 
    # API version
    # 
    # @return [String] API version used
    def version
      @version || API_VERSION
    end

    def access_url
      ENV['OKTA_URL']
    end

    # 
    # Configure Okta
    # @param params [Hash] configuration parameters
    # @option params [String] :company your company name/domain
    # @option params [String] :token Okta API token
    # @option params [String] :version Okta API version (v1 by default)
    # 
    def configure(params)
      self.company = params[:company]
      self.token = params[:token]
      self.version = params[:version]
    end

    # 
    # Request headers
    # 
    # @return [Hash] request headers
    def headers
      token = ENV['OKTA_TOKEN']
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Authorization' => "SSWS #{token}"
      }
    end

    def get(path, params = {})
      # Get URI
      uri = URI(access_url)
      uri.query = URI.encode_www_form(params)
      # Add path
      uri.path += path
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        # Execute request
        http.send_request('GET', uri, nil, headers)
      end
      # Try to parse response
      JSON.parse(res.body) rescue res.body
    end

    def post(path, data)
      uri = URI(access_url)
      uri.path += path
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = data.to_json
      res = http.request(request)
      JSON.parse(res.body) rescue res.body
    end

  end
end
