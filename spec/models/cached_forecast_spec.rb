RSpec.describe CachedForecast do
  around do |example|
    env_vars = {CERC_FORECAST_API_CACHE_LIMIT_MINS: "60"}
    ClimateControl.modify(env_vars) { example.run }
  end

  describe "validations" do
    it { should validate_presence_of(:obtained_at) }
    it { should validate_presence_of(:zone) }
    it { should validate_presence_of(:data) }

    it "validates that #data is an array of three forecasts" do
      cached_forecast = FactoryBot.build(:cached_forecast, data: FactoryBot.build_list(:forecast, 2))

      expect(cached_forecast).not_to be_valid
      expect(cached_forecast.errors[:data]).to include("must be an array of three forecasts")
    end

    it "validates that each forecast in #data has a :forecasted_at date" do
      cached_forecast = FactoryBot.build(:cached_forecast, data: [
        FactoryBot.build(:forecast, air_pollution: FactoryBot.build(:air_pollution_prediction, forecasted_at: "2024-10-21"))
      ])

      expect(cached_forecast).not_to be_valid
      expect(cached_forecast.errors[:data]).to include("forecasted_at must be a date")
    end

    it "validates that each forecast in #data has integer values for air pollution" do
      cached_forecast = FactoryBot.build(:cached_forecast, data: [
        FactoryBot.build(:forecast, air_pollution: FactoryBot.build(:air_pollution_prediction, no2: "1"))
      ])

      expect(cached_forecast).not_to be_valid
      expect(cached_forecast.errors[:data]).to include("no2 must be an integer")
    end

    it "validates that each forecast in #data has integer values for UV and pollen" do
      cached_forecast = FactoryBot.build(:cached_forecast, data: [
        FactoryBot.build(:forecast, uv: "1", pollen: "2")
      ])

      expect(cached_forecast).not_to be_valid
      expect(cached_forecast.errors[:data]).to include("uv must be an integer")
      expect(cached_forecast.errors[:data]).to include("pollen must be an integer")
    end
  end

  describe "::last" do
    let!(:first) { FactoryBot.create(:cached_forecast, obtained_at: Time.current - 2.days) }
    let!(:last) { FactoryBot.create(:cached_forecast, obtained_at: Time.current) }
    let!(:middle) { FactoryBot.create(:cached_forecast, obtained_at: Time.current - 1.day) }

    it "returns the record with the latest #obtained_at timestamp" do
      expect(CachedForecast.last).to eq(last)
    end
  end

  describe "::stale?" do
    def time_at_cache_limit
      Time.current - ENV.fetch("CERC_FORECAST_API_CACHE_LIMIT_MINS").to_i.minutes
    end

    context "when the last record is older than the CERC_FORECAST_API_CACHE_LIMIT_MINS" do
      before do
        FactoryBot.create(
          :cached_forecast,
          obtained_at: time_at_cache_limit - 1.minute
        )
      end

      it "returns _true_" do
        expect(CachedForecast.stale?).to be true
      end
    end

    context "when the last record is younger than the CERC_FORECAST_API_CACHE_LIMIT_MINS" do
      before do
        FactoryBot.create(
          :cached_forecast,
          obtained_at: time_at_cache_limit + 1.minute
        )
      end

      it "returns _false_" do
        expect(CachedForecast.stale?).to be false
      end
    end

    context "when there are no records" do
      before do
        CachedForecast.delete_all
      end

      it "returns _true_" do
        expect(CachedForecast.stale?).to be true
      end
    end
  end

  describe "::latest_for(zone)" do
    let(:brent) { FactoryBot.create(:zone, name: "Brent") }
    let(:barnet) { FactoryBot.create(:zone, name: "Barnet") }

    let!(:first_brent) {
      FactoryBot.create(:cached_forecast, zone: brent, obtained_at: Time.current - 2.days)
    }
    let!(:last_brent) {
      FactoryBot.create(:cached_forecast, zone: brent, obtained_at: Time.current)
    }
    let!(:middle_brent) {
      FactoryBot.create(:cached_forecast, zone: brent, obtained_at: Time.current - 1.day)
    }

    let!(:first_barnet) {
      FactoryBot.create(:cached_forecast, zone: barnet, obtained_at: Time.current - 2.days)
    }
    let!(:last_barnet) {
      FactoryBot.create(:cached_forecast, zone: barnet, obtained_at: Time.current)
    }
    let!(:middle_barnet) {
      FactoryBot.create(:cached_forecast, zone: barnet, obtained_at: Time.current - 1.day)
    }

    it "returns the latest record for the given zone" do
      aggregate_failures do
        expect(CachedForecast.latest_for(barnet)).to eq(last_barnet)
        expect(CachedForecast.latest_for(brent)).to eq(last_brent)
      end
    end
  end

  describe "::latest_for_all_zones" do
    let(:brent) { FactoryBot.create(:zone, name: "Brent") }
    let(:barnet) { FactoryBot.create(:zone, name: "Barnet") }

    let!(:first_brent) {
      FactoryBot.create(:cached_forecast, zone: brent, obtained_at: Time.current - 2.days)
    }
    let!(:last_brent) {
      FactoryBot.create(:cached_forecast, zone: brent, obtained_at: Time.current)
    }
    let!(:middle_brent) {
      FactoryBot.create(:cached_forecast, zone: brent, obtained_at: Time.current - 1.day)
    }

    let!(:first_barnet) {
      FactoryBot.create(:cached_forecast, zone: barnet, obtained_at: Time.current - 2.days)
    }
    let!(:last_barnet) {
      FactoryBot.create(:cached_forecast, zone: barnet, obtained_at: Time.current)
    }
    let!(:middle_barnet) {
      FactoryBot.create(:cached_forecast, zone: barnet, obtained_at: Time.current - 1.day)
    }

    it "returns the latest record for each zone" do
      expect(CachedForecast.latest_for_all_zones).to match_array([last_brent, last_barnet])
    end
  end

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

      expect(Zone).to have_received(:find_by).with(cerc_id: forecast_zone[:id])
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

      expect(cached_forecast.data.to_json).to eq(built_forecasts.to_json)
    end
  end
end
