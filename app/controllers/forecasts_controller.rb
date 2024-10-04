class ForecastsController < ApplicationController
  def show
    @forecast = JSON.parse(File.read("#{Rails.root}/public/sample-forecast.json"))["zones"][0]
    @dates = @forecast["forecasts"].map { |forecast| forecast["forecast_date"] }
  end
end
