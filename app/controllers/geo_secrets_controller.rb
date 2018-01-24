class GeoSecretsController < ApplicationController
skip_before_action :verify_authenticity_token

  def index
    
  end
  # This method will set a secret message at specific geolocation
  def create
    Rails.logger.debug params.inspect
    params[:lattitude].to_f
    params[:longitude].to_f
    geo_secret = GeoSecret.new(geo_params)
    Rails.logger.debug geo_secret.inspect
    if geo_secret.save
      Rails.logger.debug "dfs"
      render json: {status: :success}
    else
      Rails.logger.debug geo_secret.errors.messages.keys.inspect
      render json: {invalid_fields: geo_secret.errors.messages.keys}
    end
  end

  # This method will return all secret messages withing given radius around a certain position.
  def get_secrets
    render json: GeoSecret.get_secrets(params)
  end

  # This method is to return nearest secret message for a given position.
  def get_nearest_secret
    render json: GeoSecret.get_nearest_secret(params)
  end

  # whitelisting params before inserting into db
  private
  def geo_params
    params.permit(:message, :lattitude, :longitude)
  end
end
