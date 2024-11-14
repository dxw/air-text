# frozen_string_literal: true

require "rails_helper"

RSpec.describe DayTabComponent, type: :component do
  describe "daqi_indicator_colour_class" do
    context "when the air pollution level is 1" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 1), day: "today", selected_day: "today")
      }

      it "returns _bg-lime-400_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-lime-400")
      end
    end

    context "when the air pollution level is 2" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 2), day: "today", selected_day: "today")
      }

      it "returns _bg-green-400_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-green-400")
      end
    end

    context "when the air pollution level is 3" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 3), day: "today", selected_day: "today")
      }

      it "returns _bg-lime-600_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-lime-600")
      end
    end

    context "when the air pollution level is 4" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 4), day: "today", selected_day: "today")
      }

      it "returns _bg-yellow-300_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-yellow-300")
      end
    end

    context "when the air pollution level is 5" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 5), day: "today", selected_day: "today")
      }

      it "returns _bg-amber-200_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-amber-200")
      end
    end

    context "when the air pollution level is 6" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 6), day: "today", selected_day: "today")
      }

      it "returns _bg-yellow-500_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-yellow-500")
      end
    end

    context "when the air pollution level is 7" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 7), day: "today", selected_day: "today")
      }

      it "returns _bg-orange-500_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-orange-500")
      end
    end

    context "when the air pollution level is 8" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 8), day: "today", selected_day: "today")
      }

      it "returns _bg-red-500_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-red-500")
      end
    end

    context "when the air pollution level is 9" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 9), day: "today", selected_day: "today")
      }

      it "returns _bg-red-800_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-red-800")
      end
    end

    context "when the air pollution level is 10" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 10), day: "today", selected_day: "today")
      }

      it "returns _bg-stone-700_" do
        expect(component.daqi_indicator_colour_class).to eq("bg-stone-700")
      end
    end
  end

  describe "active_tab_class" do
    context "when the tab day matches the selected day" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 1), day: "tomorrow", selected_day: "tomorrow")
      }

      it "returns active" do
        expect(component.active_tab_class).to eq("active")
      end
    end

    context "when the tab day does not match the selected day" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 1), day: "today", selected_day: "tomorrow")
      }

      it "returns active" do
        expect(component.active_tab_class).to eq("inactive")
      end
    end
  end

  describe "daqi_tab_class" do
    context "when the tab day is today" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 1), day: "today", selected_day: "tomorrow")
      }

      it "returns the today class for the daqi level" do
        expect(component.daqi_tab_class).to eq("daqi-level-1-today")
      end
    end

    context "when there is an alert and the tab day matches the selected day" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 8), day: "day_after_tomorrow", selected_day: "day_after_tomorrow")
      }

      it "returns the daqi alert after today class" do
        expect(component.daqi_tab_class).to eq("daqi-alert-after-today-selected-level-8")
      end
    end

    context "when the day is not today and there is no alert" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 3), day: "day_after_tomorrow", selected_day: "today")
      }

      it "returns the after today class" do
        expect(component.daqi_tab_class).to eq("after-today")
      end
    end

    context "when the day is not today and the tab day does not match the selected day" do
      let(:component) {
        DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 10), day: "day_after_tomorrow", selected_day: "today")
      }

      it "returns the after today class" do
        expect(component.daqi_tab_class).to eq("after-today")
      end
    end
  end

  describe "tab_classes" do
    let(:component) {
      DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: 10), day: "day_after_tomorrow", selected_day: "today")
    }

    it "concatenates the daqi_tab_class and active_tab_class" do
      expect(component.tab_classes).to eq("after-today inactive")
    end
  end
end
