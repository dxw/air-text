module HttpStubs
  class << self
    def stub_forecasts_with(response)
      WebMock.stub_request(:get, %r{/getforecast/all})
        .to_return(status:  200,
          body:    response,
          headers: {"Content-Type" => "application/json"})
    end
  end
end
