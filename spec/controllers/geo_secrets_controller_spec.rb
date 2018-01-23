require "rails_helper"

RSpec.describe GeoSecretsController, type: :controller do

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Geo Secret with specified location and message" do
        expect {
          post :create, params: attributes_for(:geo_secret)
        }.to change(GeoSecret, :count).by(1)
      end
      it "returns a http response with success status" do
        post :create, params: {geo_secret: attributes_for(:geo_secret)}
        expect(response).to have_http_status(:success)
      end
    end
    context "with invalid params" do
      it "returns a error response with invalid field lattitude" do
        post :create, params: attributes_for(:geo_secret, lattitude: 220.219, longitude: 0.31, message: "Hello world")
        expect(JSON.parse(response.body)["invalid_fields"]).to eq(["lattitude"])
      end
      it "returns a error response with invalid field longitude" do
        post :create, params: attributes_for(:geo_secret, lattitude: 70.219, longitude: 190.31, message: "Hello world")
        expect(JSON.parse(response.body)["invalid_fields"]).to eq(["longitude"])
      end
      it "returns a error response with invalid field message" do
        post :create, params: attributes_for(:geo_secret, lattitude: 70.219, longitude: 120.31, message: "")
        expect(JSON.parse(response.body)["invalid_fields"]).to eq(["message"])
      end
    end
    context "#get_secrets for given specified location" do
      it "returns all valid messages" do
        geo_secret1 = create(:geo_secret, lattitude: 20.23245, longitude: 19.5848, message: "Hello")
        geo_secret2 = create(:geo_secret, lattitude: 20.22368, longitude: 19.5645, message: "Hi")
        get :get_secrets, params: { lattitude: 20.323, longitude: 19.2343, distance: 50 }
        expect(JSON.parse(response.body)["secret_messages"]).to eq(["Hello", "Hi"])
      end
    end
    context "#get_nearest_secret for given specified location" do
      it "returns nearest valid messages" do
        geo_secret1 = create(:geo_secret, lattitude: 20.23245, longitude: 19.5848, message: "Hello")
        geo_secret2 = create(:geo_secret, lattitude: 20.22368, longitude: 19.5645, message: "Hi")
        get :get_nearest_secret, params: { lattitude: 20.323, longitude: 19.2343, distance: 50 }
        expect(JSON.parse(response.body)["secret_message"]).to eq("Hi")
      end
    end
  end
end
