class WeatherDataController < ApplicationController
  before_action :authenticate

  def index
    if Current.user.resume.attached?
      # Show weather data
    else
      render json: 'Resume upload required', status: :unauthorized
    end
  end
end
