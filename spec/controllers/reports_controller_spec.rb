require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let(:user) { create :user }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #generate" do
    it "returns http success" do
      get :generate
      expect(response).to have_http_status(:success)
    end
  end

end
