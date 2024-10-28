RSpec.describe CachedForecast do
  describe "::stale?"
  describe "::latest_for"
  describe "::store" do
    let(:active_record_zone) { FactoryBot.create(:zone, cerc_id: 123) }
    let(:forecast_zone) { FactoryBot.build(:forecast_zone, id: 123) }

    let(:first_forecast) {
      FactoryBot.build(
        :forecast,
        obtained_at: Time.zone.parse("2024-10-21 17:10"),
        zone: forecast_zone
      )
    }

    let(:built_forecasts) {
      [
        first_forecast,
        FactoryBot.build(:forecast),
        FactoryBot.build(:forecast)
      ]
    }

    before { allow(Zone).to receive(:find_by).and_return(active_record_zone) }

    it "looks up activerecord Zone with Forecast#zone ID" do
      CachedForecast.store(built_forecasts)

      expect(Zone).to have_received(:find_by).with(cerc_id: forecast_zone.id)
    end

    it "sets #obtained_at from the Forecast#obtained_at timestamp" do
      cached_forecast = CachedForecast.store(built_forecasts)

      expect(cached_forecast.obtained_at).to eq(Time.zone.parse("2024-10-21 17:10"))
    end

    it "sets #zone with the looked up active record zone" do
      cached_forecast = CachedForecast.store(built_forecasts)

      expect(cached_forecast.zone).to eq(active_record_zone)
    end

    it "sets #data with the list of built forecasts for serialisation to JSONB" do
      cached_forecast = CachedForecast.store(built_forecasts)

      expect(cached_forecast.data.inspect).to eq(built_forecasts.inspect)
    end
  end
end
