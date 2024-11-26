# frozen_string_literal: true

require "rails_helper"

RSpec.describe DayTabComponent, type: :component do
  describe "daqi_indicator_colour_class" do
    context "when the air pollution level is 1" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 1), day: :today)
      }

      it "returns _daqi-level-1_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-1")
      end
    end

    context "when the air pollution level is 2" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 2), day: :today)
      }

      it "returns _daqi-level-2_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-2")
      end
    end

    context "when the air pollution level is 3" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 3), day: :today)
      }

      it "returns _daqi-level-3_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-3")
      end
    end

    context "when the air pollution level is 4" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 4), day: :today)
      }

      it "returns _daqi-level-4_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-4")
      end
    end

    context "when the air pollution level is 5" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 5), day: :today)
      }

      it "returns _daqi-level-5_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-5")
      end
    end

    context "when the air pollution level is 6" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 6), day: :today)
      }

      it "returns _daqi-level-6_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-6")
      end
    end

    context "when the air pollution level is 7" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 7), day: :today)
      }

      it "returns _daqi-level-7_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-7")
      end
    end

    context "when the air pollution level is 8" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 8), day: :today)
      }

      it "returns _daqi-level-8_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-8")
      end
    end

    context "when the air pollution level is 9" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 9), day: :today)
      }

      it "returns _daqi-level-9_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-9")
      end
    end

    context "when the air pollution level is 10" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 10), day: :today)
      }

      it "returns _daqi-level-10_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-10")
      end
    end
  end

  describe "icon_stroke_colour_class" do
    let(:component) {
      forecast = FactoryBot.build(:forecast, air_pollution: FactoryBot.build(:air_pollution_prediction, label: label))
      DayTabComponent.new(forecast: forecast, day: :today)
    }

    context "when the air pollution label is _HIGH_" do
      let(:label) { "HIGH" }

      it "returns _stroke-white_" do
        expect(component.icon_stroke_colour_class).to eq("stroke-white")
      end
    end

    context "when the air pollution label is _MODERATE_" do
      let(:label) { "MODERATE" }

      it "returns _stroke-black_" do
        expect(component.icon_stroke_colour_class).to eq("stroke-black")
      end
    end
  end
end
