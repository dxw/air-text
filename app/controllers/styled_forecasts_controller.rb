class StyledForecastsController < ApplicationController
  layout "tailwind_layout"
  def show
    @forecasts = CercApiClient
      .forecasts_for(params.has_key?("zone") ? params["zone"] : "Southwark")
  end
end
