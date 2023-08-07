require 'rails_helper'

RSpec.describe 'WeatherData', type: :request do
  before do
    allow_any_instance_of(ApplicationController).to receive(:authenticate).and_return('test_token')
    allow_any_instance_of(Current).to receive(:user).and_return(User.new)
    allow_any_instance_of(WeatherDataController).to receive(:resume_present?).and_return(true)
    allow_any_instance_of(WeatherDataFetcher).to receive(:call).and_return(nil)
  end

  describe 'GET /weather_data' do
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

  describe 'POST /weather_data' do
    context 'when all params are present' do
      let(:params) do
        { "weather_data": [
            {
              "time": '2023-08-05T00:00',
              "temperature": -29.0
            },
            {
              "time": '2023-08-05T01:00',
              "temperature": -25.8
            }
          ],
          "title": 'Antarctica on my 18th birthday' }
      end

      it 'renders 200, json' do

        post weather_data_path(params)

        expect(response.status).to eq(200), 'Code not 200'
      end
    end

    context 'when the user is missing' do
      let(:params) do
        { "weather_data": [
            {
              "time": '2023-08-05T00:00',
              "temperature": -29.0
            },
            {
              "time": '2023-08-05T01:00',
              "temperature": -25.8
            }
          ],
          "title": 'Antarctica on my 18th birthday' }
      end

      it 'renders 500, json' do
        allow_any_instance_of(Current).to receive(:user).and_return(nil)

        post weather_data_path(params)

        expect(response.status).to eq(500), 'Code not 500'
      end
    end

    context 'when the weather_data is missing' do
      let(:params) do
        {
          "title": 'Antarctica on my 18th birthday'
        }
      end

      it 'renders 400, json' do

        post weather_data_path(params)

        expect(response.status).to eq(400), 'Code not 400'
      end
    end

    context "when the user's resume is missing" do
      let(:params) do
        { "weather_data": [
            {
              "time": '2023-08-05T00:00',
              "temperature": -29.0
            },
            {
              "time": '2023-08-05T01:00',
              "temperature": -25.8
            }
          ],
          "title": 'Antarctica on my 18th birthday' }
      end

      it 'renders 401, json' do
        allow_any_instance_of(WeatherDataController).to receive(:resume_present?).and_return(false)

        post weather_data_path(params)

        expect(response.status).to eq(401), 'Code not 401'
      end
    end
  end
end
