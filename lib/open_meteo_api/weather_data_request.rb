module OpenMeteoApi
  class WeatherDataRequest
    require 'net/http'

    def initialize(params)
      @params = params
    end

    def get
      uri = URI.parse(request_url)
      response = Net::HTTP.start(uri.host, uri.port,
                                 use_ssl: uri.scheme == 'https') do |http|
        request = Net::HTTP::Get.new uri
        http.request(request)
      end
      JSON.parse(response&.body)
    end

    private

    def request_url
      "https://api.open-meteo.com/v1/forecast?latitude=#{@params[:latitude]}&longitude=#{@params[:longitude]}&hourly=temperature_2m"
    end
  end
end
