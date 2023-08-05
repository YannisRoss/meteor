class CreateStoredWeatherDataObjects < ActiveRecord::Migration[7.0]
  def change
    create_table :stored_weather_data_objects do |t|
      t.json :contents
      t.belongs_to :user

      t.timestamps
    end
  end
end
