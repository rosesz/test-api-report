module Reports
  class ItemData
    attr_accessor :item_name, :start_date, :end_date, :item_total, :count

    alias_attribute :total, :item_total

    def average
      return unless count
      (total / count) * 100
    end
  end
end