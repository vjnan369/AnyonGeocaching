class GeoSecret < ApplicationRecord
  require 'geocoder'
  validates :lattitude, :longitude, :message, presence: true
  validates_inclusion_of :lattitude, :in => -90..90
  validates_inclusion_of :longitude, :in => -180..180
  # This MAX_GEO_DISTANCE is the maximum possible distance between two specified location on earth.
  MAX_GEO_DISTANCE = 41000

  # This method will return all secret messages withing given radius around a certain position.
  def self.get_secrets(params)
    Rails.logger.debug params.inspect
    secret_messages = []
    GeoSecret.all.each do |secret|
      geo_distance = get_geo_distance(params[:lattitude], params[:longitude], secret.lattitude, secret.longitude)
      if geo_distance <= params[:distance].to_f
        secret_messages << secret.message
      end
    end
    return {status: :success, secret_messages: secret_messages}
  end

  # This method is to return nearest secret message for a given position.
  def self.get_nearest_secret(params)
    secret_message = ""
    distance = MAX_GEO_DISTANCE;
    GeoSecret.all.each do |secret|
      geo_distance = get_geo_distance(params[:lattitude], params[:longitude], secret.lattitude, secret.longitude)
      if geo_distance <= distance.to_f
        secret_message = secret.message
        distance = geo_distance
      end
    end
    return {status: :success, secret_message: secret_message}
  end

  # This method will return distance between two specified positions in kilometers.
  def self.get_geo_distance(given_lattitude, given_longitude, secret_lattitude, secret_longitude)
    return Geocoder::Calculations.distance_between([given_lattitude, given_longitude], [secret_lattitude, secret_longitude], {units: :km})
  end
end
