module Api 
  class ReportsController < ApiController
  	before_action :require_login!

    def index
      reports = current_user.reports
      render json: reports
    end

    def generate
      render json: {
        comment: params[:comment],
        generated_at: Time.now,
        items_data: Reports::DataFetcher.call
      }
    end
  end
end