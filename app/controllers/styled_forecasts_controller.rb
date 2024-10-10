class StyledForecastsController < ApplicationController
  layout "tailwind_layout"
  def show
    @forecasts = CercApiClient
      .forecasts_for(params.fetch("zone", "Southwark"))
  end
end
