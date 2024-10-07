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

  describe "tag_colour" do
    context "when the #level is 'moderate'" do
      let(:forecast) do
        FactoryBot.build(
          :forecast,
          air_pollution: FactoryBot.build(
            :air_pollution_prediction,
            overall_label: "MODERATE"
          )
        )
      end

      let(:alert) { AirQualityAlert.new(forecast) }

      it "returns _yellow_" do
        expect(alert.tag_colour).to eq(:yellow)
      end
    end

    context "when the #level is 'high'" do
      let(:forecast) do
        FactoryBot.build(
          :forecast,
          air_pollution: FactoryBot.build(
            :air_pollution_prediction,
            overall_label: "HIGH"
          )
        )
      end

      let(:alert) { AirQualityAlert.new(forecast) }

      it "returns _red_" do
        expect(alert.tag_colour).to eq(:red)
      end
    end

    context "when the #level is 'very high'" do
      let(:forecast) do
        FactoryBot.build(
          :forecast,
          air_pollution: FactoryBot.build(
            :air_pollution_prediction,
            overall_label: "VERY HIGH"
          )
        )
      end

      let(:alert) { AirQualityAlert.new(forecast) }

      it "returns _purple_" do
        expect(alert.tag_colour).to eq(:purple)
      end
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
