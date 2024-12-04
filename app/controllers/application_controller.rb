# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :dummy_forecast

  def health_check
    render json: {
      rails: "OK",
      git_sha: ENV.fetch("CURRENT_GIT_SHA", "UNKNOWN"),
      built_at: ENV.fetch("TIME_OF_BUILD", "UNKNOWN")
    }, status: :ok
  end

  def dummy_forecast
    ENV["DUMMY_FORECAST"] = params[:dummy]
  end
end
