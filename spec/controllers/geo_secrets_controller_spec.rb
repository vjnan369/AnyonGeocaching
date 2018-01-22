require "rails_helper"

RSpec.describe GeoSecretsController, type: :controller do

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Geo Secret with specified location and message" do
        expect {
          post :create, params: { geo_secret: attributes_for(:geo_secret) }
        }.to change(GeoSecret, :count).by(1)
      end
      it "returns a http response with success status" do
        post :create, params: {geo_secret: attributes_for(:geo_secret)}
        expect(response).to have_http_status(:success)
      end
    end
    context "with invalid params" do
      it "creates a new Geo Secret with specified location and message" do
        expect {
          post :create, params: { geo_secret: attributes_for(:geo_secret) }
        }.to change(GeoSecret, :count).by(1)
      end
      it "returns a http response with success status" do
        post :create, params: {geo_secret: attributes_for(:geo_secret)}
        expect(response).to have_http_status(:success)
      end
    end
  end
end
