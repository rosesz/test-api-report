require "csv"

module Reports
  class Creator
    attr_accessor :user, :comment

    def initialize(comment, user)
      @user    = user
      @comment = comment
    end

    def self.call(comment, user)
      new(comment, user).call
    end

    def call
      generation_time = Time.now
      report = Report.new(comment: comment, generated_at: generation_time, user: user)
      items_data = DataFetcher.call
      report.save

      CSVReport.new(csv_document(items_data), "#{user.id}_#{generation_time.to_date.to_s}.csv")
    end

    private

    def csv_document(items_data)
      headers = ["Item name", "Start date", "End date", "Total", "Count", "Average"]

     CSV.generate do |csv|
        csv << headers
        items_data.each do |data|
          csv << [data.item_name, data.start_date, data.end_date, data.total, data.count, data.average]
        end
      end
    end
  end

  class CSVReport < Struct.new(:document, :filename); end
end