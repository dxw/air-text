RSpec.describe AirQualityAlert do
  let(:forecast) do
    FactoryBot.build(
      :forecast,
      forecast_for: Date.tomorrow,
      air_pollution: FactoryBot.build(:air_pollution_prediction, :high)
    )
  end

  let(:alert) { AirQualityAlert.new(forecast) }

  describe "date" do
    it "returns the associated forecast's date" do
      expect(alert.date).to eq(Date.tomorrow)
    end
  end

  describe "tag_colour" do
    context "when the #daqi_level is 'moderate'" do
      let(:forecast) do
        FactoryBot.build(
          :forecast,
          air_pollution: FactoryBot.build(:air_pollution_prediction, :moderate)
        )
      end

      let(:alert) { AirQualityAlert.new(forecast) }

      it "returns _yellow_" do
        expect(alert.tag_colour).to eq(:yellow)
      end
    end

    context "when the #daqi_level is 'high'" do
      let(:forecast) do
        FactoryBot.build(
          :forecast,
          air_pollution: FactoryBot.build(:air_pollution_prediction, :high)
        )
      end

      let(:alert) { AirQualityAlert.new(forecast) }

      it "returns _red_" do
        expect(alert.tag_colour).to eq(:red)
      end
    end

    context "when the #daqi_level is 'very high'" do
      let(:forecast) do
        FactoryBot.build(
          :forecast,
          air_pollution: FactoryBot.build(:air_pollution_prediction, :very_high)
        )
      end

      let(:alert) { AirQualityAlert.new(forecast) }

      it "returns _purple_" do
        expect(alert.tag_colour).to eq(:purple)
      end
    end
  end

  describe "#daqi_label" do
    it "returns the associated forecast's air pollution prediction's daqi_label" do
      expect(alert.daqi_label).to eq("High")
    end
  end

  describe "#daqi_level" do
    it "returns the associated forecast's air pollution prediction's daqi_level" do
      expect(alert.daqi_level).to eq(:high)
    end
  end

  describe "#value" do
    it "returns the associated forecast's air pollution prediction's value" do
      expect(alert.value).to be >= (7)
    end
  end
end
