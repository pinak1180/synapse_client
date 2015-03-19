
module SynapseClient
  class Order < APIResource
    include SynapseClient::APIOperations::List

    attr_reader :status
    attr_reader :amount
    attr_reader :seller_email
    attr_reader :seller_id
    attr_reader :bank_pay
    attr_reader :bank_id
    attr_reader :note
    attr_reader :date_settled
    attr_reader :date
    attr_reader :ticket_number
    attr_reader :resource_uri
    attr_reader :account_type
    attr_reader :fee

    def initialize(options = {})
      @status        = options[:status]
      @amount        = options[:amount]
      @seller_email  = options[:seller_email]
      @bank_pay      = options[:bank_pay]
      @bank_id       = options[:bank_id]
      @note          = options[:note]
      @date_settled  = options[:date_settled]
      @date          = options[:date]
      @id            = options[:id]
      @ticket_number = options[:ticket_number]
      @resource_uri  = options[:resource_uri]
      @account_type  = options[:account_type]
      @fee           = options[:fee]
      @seller_id     = options[:seller_id]     || options[:seller].delete("seller_id") rescue nil
    end

    def submit(client)
      data = {
        :amount       => @amount,
        :seller_email => @seller_email,
        :bank_pay     => @bank_pay,
        :bank_id      => @bank_id,
        :note         => @note,
        :seller_id    => @seller_id
      }

      request  = SynapseClient::Request.new("/api/v2/order/add/", data, client)
      request.post
    end

    def self.all(params={})
      orders = list(params, "recent").orders
      orders.map{|order| Order.new(order)}
    end

    def self.create(params={})
      response = SynapseClient.request(:post, url + "add", params)

      return response unless response.successful?
      Order.new(response.data.order)
    end

  end
end

