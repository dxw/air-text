RSpec.describe Forecast do
  describe "#alerts" do
    let(:alert) { double("air quality alert") }
    before { allow(AirQualityAlert).to receive(:new).and_return(alert) }

    context "when an Air Quality Alert exists" do
      let(:forecast) do
        FactoryBot.build(
          :forecast,
          air_pollution: FactoryBot.build(
            :air_pollution_prediction,
            overall_label: "HIGH"
          )
        )
      end

      it "includes the Air Quality Alert in the list" do
        expect(forecast.alerts).to eq([alert])
      end
    end

    context "when an Air Quality Alert does NOT exist" do
      let(:forecast) do
        FactoryBot.build(
          :forecast,
          air_pollution: FactoryBot.build(
            :air_pollution_prediction,
            overall_label: "LOW"
          )
        )
      end

      it "returns an empty list" do
        expect(forecast.alerts).to be_empty
      end
    end
  end

  describe "#air_quality_alerts" do
    let(:alert) { double("air quality alert") }
    before { allow(AirQualityAlert).to receive(:new).and_return(alert) }

    context "when the air pollution overall status is LOW" do
      let(:forecast) do
        FactoryBot.build(
          :forecast,
          air_pollution: FactoryBot.build(
            :air_pollution_prediction,
            overall_label: "LOW"
          )
        )
      end

      it "returns _false_" do
        expect(forecast.air_quality_alert).to be_nil
      end
    end

    context "when the air pollution overall status not LOW" do
      ["MODERATE", "HIGH", "VERY HIGH"].each do |status|
        let(:forecast) do
          FactoryBot.build(
            :forecast,
            air_pollution: FactoryBot.build(
              :air_pollution_prediction,
              overall_label: status
            )
          )
        end

        it "returns an Air Quality Alert" do
          expect(forecast.air_quality_alert).to eq(alert)
        end
      end
    end
  end
end
