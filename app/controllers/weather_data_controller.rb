class WeatherDataController < ApplicationController
  before_action :authenticate

  # GET /weather_data
  def index
    if has_resume?
      if permitted_params[:latitude].present? && permitted_params[:longitude].present?
        weather_data = WeatherDataFetcher.call(permitted_params)
        render json: weather_data, status: :ok
      else
        render json: 'Latitude and longitude required', status: :bad_request
      end

    else
      render json: 'Resume upload required', status: :unauthorized
    end
  end

  private

  def permitted_params
    params.permit(:latitude, :longitude)
  end

  def has_resume?
    Current.user.resume.attached?
  end
end
