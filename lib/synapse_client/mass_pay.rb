module SynapseClient
  class MassPay < APIResource
    include SynapseClient::APIOperations::List

    attr_accessor :mass_pays,:passcode,:account_class,:account_number_string
    attr_accessor :account_type,:amount,:date,:fee
    attr_accessor :id,:name_on_account,:resource_uri,:routing_number_string
    attr_accessor :status,:status_url,:supp_id,:trans_type

    def initialize(options = {})
      options = Map.new(options)
      @mass_pays         = options[:mass_pays]
      @passcode          = optins[:passcode]
      @account_class    = options[:account_class]
      @account_number_string = options[:account_number_string]
      @account_type   = options[:account_type]
      @amount         = options[:amount]
      @fee            = options[:fee]
      @date           = options[:date]
      @id             = options[:id]
      @name_on_account = options[:name_on_account]
      @resource_uri    = options[:resource_uri]
      @routing_number_string = options[:routing_number_string]
      @status = options[:status]
      @status_url = options[:status_url]
      @supp_id = options[:supp_id]
      @trans_type = options[:trns_type]
    end

    def self.api_resource_name
      "masspay"
    end

    def self.all(params={})
      cards = list(params).cards
      cards.map{|ca| Card.new(ca)}
    end

    def self.via_card(params={})
      response = SynapseClient.request(:post, url + "add", params)
      return response unless response.successful?
      MassPay.new(response.data.mass_pays)
    end
  end
end
