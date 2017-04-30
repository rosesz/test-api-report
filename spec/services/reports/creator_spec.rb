require 'rails_helper'

RSpec.describe Reports::Creator do
  subject { described_class.new(comment, user) }
  
  let(:user)    { create :user, id: 12 }
  let(:time)    { Time.new(2002, 10, 31) }
  let(:comment) { "Lorem ipsum" }
  let(:item_data) { build :item_data, item_name: "Test item" }

  before do
    allow(Reports::DataFetcher).to receive(:call).and_return([item_data])
  end

  it "creates new report" do
    expect { subject.call }.to change { Report.count }.by(1)
  end

  it "sets report comment to given comment" do
    subject.call

    report = Report.last
    expect(report.comment).to eq(comment)
  end

  it "sets generation time" do
    Timecop.freeze(time) do
      subject.call
    end

    report = Report.last
    expect(report.generated_at).to eq(time)
  end

  it "builds correct filename" do
    Timecop.freeze(time) do
      csv_report = subject.call

      expect(csv_report.filename).to eq("12_2002-10-31.csv")
    end
  end
end
