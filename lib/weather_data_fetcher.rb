class WeatherDataFetcher
  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @params = params
  end

  def call
    result = OpenMeteoApi::WeatherDataRequest.new(@params).get

    sanitize(result)
  end

  private

  def sanitize(result)
    temperatures = result.dig('hourly', 'temperature_2m')

    result.dig('hourly', 'time').map.with_index { |time, index| { time: time, temperature: temperatures[index] } }
  end
end
