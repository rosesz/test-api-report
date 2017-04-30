FactoryGirl.define do
  factory :item_data, class: "Reports::itemData" do
    sequence(:item_name) { |n| "name#{n}" }
    start_on Time.now
  end
end