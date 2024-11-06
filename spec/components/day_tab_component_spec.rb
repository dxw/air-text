# frozen_string_literal: true

require "rails_helper"

RSpec.describe DayTabComponent, type: :component do
  describe "daqi_indicator_colour_class" do
    context "when the air pollution level is 1" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, :air_pollution_level_1), day: :today)
      }

      it "returns _bg-lime-400_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-lime-400")
      end
    end

    context "when the air pollution level is 2" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, :air_pollution_level_2), day: :today)
      }

      it "returns _bg-green-400_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-green-400")
      end
    end

    context "when the air pollution level is 3" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, :air_pollution_level_3), day: :today)
      }

      it "returns _bg-lime-600_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-lime-600")
      end
    end

    context "when the air pollution level is 4" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, :air_pollution_level_4), day: :today)
      }

      it "returns _bg-yellow-300_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-yellow-300")
      end
    end

    context "when the air pollution level is 5" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, :air_pollution_level_5), day: :today)
      }

      it "returns _bg-amber-200_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-amber-200")
      end
    end

    context "when the air pollution level is 6" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, :air_pollution_level_6), day: :today)
      }

      it "returns _bg-yellow-500_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-yellow-500")
      end
    end

    context "when the air pollution level is 7" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, :air_pollution_level_7), day: :today)
      }

      it "returns _bg-orange-500_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-orange-500")
      end
    end

    context "when the air pollution level is 8" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, :air_pollution_level_8), day: :today)
      }

      it "returns _bg-red-500_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-red-500")
      end
    end

    context "when the air pollution level is 9" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, :air_pollution_level_9), day: :today)
      }

      it "returns _bg-red-800_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-red-800")
      end
    end

    context "when the air pollution level is 10" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, :air_pollution_level_10), day: :today)
      }

      it "returns _bg-stone-700_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-stone-700")
      end
    end
  end

  describe "classes" do
    context "when the day is today" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, :air_pollution_level_1), day: :today)
      }

      it "returns the classes for today's tab" do
        expect(component.classes).to eq("active daqi-level-1-today")
      end
    end

    context "when the day is not today" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, :air_pollution_level_1), day: :tomorrow)
      }

      it "returns the classes for the after today tabs" do
        expect(component.classes).to eq("inactive after-today")
      end
    end
  end
end
