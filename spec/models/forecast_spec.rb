RSpec.describe Forecast do
  describe "#air_quality_alerts" do
    let(:alert) { double("air quality alert") }

    context "when the air pollution overall DAQI level is LOW" do
      let(:forecast) do
        FactoryBot.build(
          :forecast,
          air_pollution: FactoryBot.build(:air_pollution_prediction, :low)
        )
      end

      it "returns _false_" do
        expect(forecast.air_quality_alert?).to be false
      end
    end

    context "when the air pollution overall DAQI level is not LOW" do
      [:moderate, :high, :very_high].each do |daqi_level|
        let(:forecast) do
          FactoryBot.build(
            :forecast,
            air_pollution: FactoryBot.build(:air_pollution_prediction, daqi_level)
          )
        end

        it "returns an Air Quality Alert" do
          expect(forecast.air_quality_alert?).to be true
        end
      end
    end
  end

  describe "#share_message" do
    let(:forecast) do
      FactoryBot.build(
        :forecast,
        date: Date.new(2021, 1, 1),
        zone: FactoryBot.build(:zone, name: "London"),
        air_pollution: FactoryBot.build(:air_pollution_prediction, :high)
      )
    end

    it "returns the share message" do
      expect(forecast.share_message).to eq(
        "On #{forecast.date.strftime("%A %d/%m/%Y")} the air pollution forecast for #{forecast.zone[:name]} is #{forecast.air_pollution[:label]} (#{forecast.air_pollution[:total]}/10). To learn more, visit https://airtext.info."
      )
    end
  end
end
