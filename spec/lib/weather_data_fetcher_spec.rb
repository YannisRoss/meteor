require 'rails_helper'

RSpec.describe WeatherDataFetcher do
  describe '#call' do
    subject { WeatherDataFetcher.call(longitude: 10, latitude: 10) }

    context 'when a request is made' do
      let(:params) { { latitude: 10, longitude: 10 } }

      it 'makes a OpenMeteoApi::WeatherDataRequest with latitude and longitude' do
        expect(OpenMeteoApi::WeatherDataRequest).to receive(:new)
          .with(params).and_call_original

        subject
      end
    end
  end
end
