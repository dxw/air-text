RSpec.describe AirQualityAlert do
  let(:forecast) do
    FactoryBot.build(
      :forecast,
      forecast_for: Date.tomorrow,
      air_pollution: FactoryBot.build(
        :air_pollution_prediction,
        overall_label: "HIGH",
        overall_score: 8
      )
    )
  end

  let(:alert) { AirQualityAlert.new(forecast) }

  describe "date" do
    it "returns the associated forecast's date" do
      expect(alert.date).to eq(Date.tomorrow)
    end
  end

  describe "#level" do
    it "returns the associated forecast's air pollution prediction's overall_label" do
      expect(alert.level).to eq("High")
    end
  end

  describe "#score" do
    it "returns the associated forecast's air pollution prediction's overall_score" do
      expect(alert.score).to eq(8)
    end
  end
end
