require 'rails_helper'

RSpec.describe OthersController, type: :controller do

  describe "GET #about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #inquiry" do
    it "returns http success" do
      get :inquiry
      expect(response).to have_http_status(:success)
    end
  end

end
