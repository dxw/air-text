# frozen_string_literal: true

Rails.application.routes.draw do
  get "health_check" => "application#health_check"

  root to: "visitors#index"

  get "map", to: "map#show"

  get :forecast, to: "forecasts#show"
  get :styled_forecast, to: "styled_forecasts#show"
  get :update_styled_forecast, to: "styled_forecasts#update"

  # If the CANONICAL_HOSTNAME env var is present, and the request doesn't come from that
  # hostname, redirect us to the canonical hostname with the path and query string present
  if ENV["CANONICAL_HOSTNAME"].present?
    constraints(host: Regexp.new("^(?!#{Regexp.escape(ENV["CANONICAL_HOSTNAME"])})")) do
      match "/(*path)" => redirect(host: ENV["CANONICAL_HOSTNAME"]), :via => [:all]
    end
  end
end
