class StyledForecastsController < ApplicationController
  layout "tailwind_layout"
  def show
    @forecasts = CercApiClient
      .forecasts_for(params.fetch("zone", "Southwark"))
  end

  def update
    @forecasts = CercApiClient
      .forecasts_for(params.fetch("zone", "Southwark"))
    render turbo_stream: turbo_stream.replace("day_predictions", partial: "predictions", locals: {forecast: @forecasts.second})
  end
end
