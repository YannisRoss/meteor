class AddTitleToStoredWeatherDataObjects < ActiveRecord::Migration[7.0]
  def change
    add_column :stored_weather_data_objects, :title, :string
  end
end
