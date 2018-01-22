class CreateGeoSecrets < ActiveRecord::Migration[5.1]
  def change
    create_table :geo_secrets do |t|
      t.string :message
      t.float :lattitude
      t.float :longitude
      t.timestamps
    end
  end
end
