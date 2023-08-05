require 'rails_helper'

RSpec.describe 'WeatherData', type: :request do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate).and_return(1)
    allow_any_instance_of(WeatherDataController).to receive(:has_resume?).and_return(true)
    allow_any_instance_of(WeatherDataFetcher).to receive(:call).and_return(nil)
  end

  describe 'http://localhost:3000/weather_data' do
    context 'when both latitude and longitude are present' do
      let(:params) { { latitude: 10, longitude: 10 } }

      it 'renders 200, json' do
        get weather_data_path(params)

        expect(response.status).to eq(200), 'Code not 200'
      end
    end

    context 'when a coordinate is missing' do
      let(:params) { { latitude: 10 } }

      it 'renders 400, json' do
        get weather_data_path(params)

        expect(response.status).to eq(400), 'Code not 400'
      end
    end
  end
end
