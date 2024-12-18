# frozen_string_literal: true

RSpec.describe AirQualityAlertBannerComponent, type: :component do
  let(:forecasts) { [FactoryBot.build(:forecast, air_pollution: FactoryBot.build(:air_pollution_prediction, air_pollution_level))] }
  let(:cached_forecast) { FactoryBot.build(:cached_forecast, data: forecasts) }

  before do
    allow(CercForecastService).to receive(:latest_forecasts).and_return([cached_forecast])
  end

  let(:component) { AirQualityAlertBannerComponent.new }

  describe "alert?" do
    context "when the air pollution level is LOW" do
      let(:air_pollution_level) { :low }

      it "returns false" do
        expect(component.alert?).to eq(false)
      end
    end

    context "when the air pollution level is not LOW" do
      let(:air_pollution_level) { :high }

      it "returns true" do
        expect(component.alert?).to eq(true)
      end
    end
  end

  describe "message" do
    context "when there is an alert" do
      let(:air_pollution_level) { :high }

      it "returns a message with the highest alert" do
        expect(component.message).to eq("High air pollution alert")
      end
    end

    context "when there is no alert" do
      let(:air_pollution_level) { :low }

      it "returns a message with no alerts" do
        expect(component.message).to eq("No air pollution alerts")
      end
    end
  end

  describe "pollution_labels" do
    let(:forecasts) {
      [
        FactoryBot.build(:forecast, air_pollution: FactoryBot.build(:air_pollution_prediction, :low)),
        FactoryBot.build(:forecast, air_pollution: FactoryBot.build(:air_pollution_prediction, :high))
      ]
    }

    it "returns the labels of the air pollution predictions" do
      expect(component.send(:pollution_labels)).to eq([["LOW", "HIGH"]])
    end
  end

  describe "highest_alert" do
    let(:forecasts) {
      [
        FactoryBot.build(:forecast, air_pollution: FactoryBot.build(:air_pollution_prediction, :low)),
        FactoryBot.build(:forecast, air_pollution: FactoryBot.build(:air_pollution_prediction, air_pollution_level))
      ]
    }

    context "when the highest alert is VERY HIGH" do
      let(:air_pollution_level) { :very_high }

      it "returns VERY HIGH" do
        expect(component.send(:highest_alert)).to eq("VERY HIGH")
      end
    end

    context "when the highest alert is HIGH" do
      let(:air_pollution_level) { :high }

      it "returns LOW" do
        expect(component.send(:highest_alert)).to eq("HIGH")
      end
    end
  end
end
