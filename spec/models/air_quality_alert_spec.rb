RSpec.describe AirQualityAlert do
  let(:forecast) do
    FactoryBot.build(
      :forecast,
      date: Date.tomorrow,
      air_pollution: FactoryBot.build(:air_pollution_prediction, :high)
    )
  end

  let(:alert) { FactoryBot.build(:air_quality_alert, forecast: forecast) }

  describe "date" do
    it "returns the associated forecast's date" do
      expect(alert.date).to eq(Date.tomorrow)
    end
  end

  describe "#daqi_label" do
    it "returns the associated forecast's air pollution prediction's daqi_label" do
      expect(alert.daqi_label).to eq("HIGH")
    end
  end

  describe "#value" do
    it "returns the associated forecast's air pollution prediction's value" do
      expect(alert.value).to be >= (7)
    end
  end
end
