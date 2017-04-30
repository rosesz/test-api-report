class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reports = current_user.reports
  end

  def generate
    comment = params.dig(:report, :comment)
    csv_report = Reports::Creator.call(comment, current_user)

    respond_to do |format|
      format.html
      format.csv { send_data csv_report.document, filename: csv_report.filename }
    end
  end
end
