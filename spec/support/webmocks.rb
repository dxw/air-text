module HttpStubs
  class << self
    def stub_forecasts_api_with(forecasts)
      forecast_response = Fixtures::API.all_forecasts(forecasts)
      WebMock.stub_request(:get, %r{/getforecast/all})
        .to_return(status:  200,
          body:    forecast_response.to_json,
          headers: {"Content-Type" => "application/json"})
    end

    def stub_send_verification_code
      WebMock.stub_request(:post, %r{/send-verification-code})
        .to_return(status: 200, body: "success")
    end
  end
end
