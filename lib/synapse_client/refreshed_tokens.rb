
module SynapseClient
  class RefreshedTokens < APIResource

    attr_reader :old_access_token
    attr_reader :old_refresh_token
    attr_accessor :new_access_token
    attr_accessor :new_refresh_token

    def initialize(options = {})
      options = Map.new(options)

      @old_access_token = options[:old_access_token]
      @old_refresh_token = options[:old_refresh_token]
    end

    def refresh_old_tokens
      client_id = SynapseClient.client_id
      client_secret =  SynapseClient.client_secret
      data = {
        :grant_type => "refresh_token",
        :refresh_token => @old_refresh_token
      }.merge(SynapseClient.creds(client_id,client_secret ))

      request = JSON.parse(RestClient.post SynapseClient.api_url("/oauth2/access_token"), data, :content_type => :json, :accept => :json)
      self.new_access_token  = request["access_token"]
      self.new_refresh_token = request["refresh_token"]

      return self
    end

  end
end
