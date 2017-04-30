require "faraday"

module Reports
  class DataFetcher
    attr_accessor :items, :report, :token

    def self.call
      new.call
    end

    def call
      authorize
      fetch_items
      fetch_report

      items_data
    end

    private

    def authorize
      params = { 
        user:          ENV['USER'],
        password:      ENV['PASSWORD'],
        client_id:     ENV['CLIENT_ID'], 
        client_secret: ENV['CLIENT_SECRET'] 
      }

      conn = Faraday.new(
        url: "#{ENV['URL']}/api/tokens",
        params: params
      )

      response = conn.post

      @token = JSON.parse(response.body)["token"]
    end

    def fetch_items
      conn = Faraday.new(url: "#{ENV['URL']}/api/items") 
      conn.headers["API-AccessToken"] = token

      response = conn.get
      @items = JSON.parse(response.body)
    end

    def fetch_report
      params = { report: { pe: 50 } }

      conn = Faraday.new(
        url: "#{ENV['URL']}/api/reports",
        params: params
      ) 

      conn.headers["API-AccessToken"] = token
      
      response = conn.post
      @report = JSON.parse(response.body)&.with_indifferent_access
    end

    def items_data
      report[:results].map do |result|
        ItemData.new.tap do |item|
          fields = %w(item_name item_total count)

          fields.each do |field|
            item.public_send("#{field}=", result[field])
          end

          details = items.find { |ca| ca["id"] == result["item_id"] }

          return unless details

          item.start_date = details["start_on"] 
          item.end_date   = details["end_on"] 
        end
      end
    end
  end
end