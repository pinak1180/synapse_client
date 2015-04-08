module SynapseClient
  class Card < APIResource
    include SynapseClient::APIOperations::List

    attr_accessor :legal_name,:account_number,:routing_number
    attr_accessor :account_class, :account_type

    def initialize(options = {})
      options = Map.new(options)

      @legal_name         = options[:legal_name]
      @account_number     = options[:account_number]
      @routing_number     = options[:routing_number]
      @account_class      = options[:account_class]
      @account_type       = options[:account_type]
    end

    def self.api_resource_name
      "card"
    end

    def self.all(params={})
      bank_accounts = list(params).banks
      bank_accounts.map{|ba| BankAccount.new(ba)}
    end

    def self.add(params={})
      response = SynapseClient.request(:post, url + "add", params)
      return response unless response.successful?
      response.data.card
    end
  end
end
