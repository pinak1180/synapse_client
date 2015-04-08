module SynapseClient
  class Card < APIResource
    include SynapseClient::APIOperations::List

    attr_accessor :legal_name,:account_number,:routing_number,:resource_uri
    attr_accessor :account_class, :account_type,:routing_number_string,:name_on_account
    attr_accessor :id,:account_number_string

    def initialize(options = {})
      options = Map.new(options)

      @legal_name         = options[:legal_name]
      @account_number     = options[:account_number]
      @routing_number     = options[:routing_number]
      @account_class      = options[:account_class]
      @account_type       = options[:account_type]
      @account_number_string = options[:account_number_string]
      @id = options[:id]
      @name_on_account = options[:name_on_account]
      @routing_number_string = options[:routing_number_string]
      @resource_uri = options[:resource_uri]
    end

    def self.api_resource_name
      "card"
    end

    def self.all(params={})
      cards = list(params).cards
      cards.map{|ca| Card.new(ca)}
    end

    def self.add(params={})
      response = SynapseClient.request(:post, url + "add", params)
      return response unless response.successful?
      Card.new(response.data.card)
    end
  end
end
