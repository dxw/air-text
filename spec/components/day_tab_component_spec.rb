# frozen_string_literal: true

RSpec.describe DayTabComponent, type: :component do
  describe "daqi_indicator_colour_class" do
    let(:component) {
      DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: air_pollution_level), active_date: Date.today)
    }

    context "when the air pollution level is 1" do
      let(:air_pollution_level) { 1 }

      it "returns _daqi-level-1_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-1")
      end
    end

    context "when the air pollution level is 2" do
      let(:air_pollution_level) { 2 }

      it "returns _daqi-level-2_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-2")
      end
    end

    context "when the air pollution level is 3" do
      let(:air_pollution_level) { 3 }

      it "returns _daqi-level-3_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-3")
      end
    end

    context "when the air pollution level is 4" do
      let(:air_pollution_level) { 4 }

      it "returns _daqi-level-4_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-4")
      end
    end

    context "when the air pollution level is 5" do
      let(:air_pollution_level) { 5 }

      it "returns _daqi-level-5_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-5")
      end
    end

    context "when the air pollution level is 6" do
      let(:air_pollution_level) { 6 }

      it "returns _daqi-level-6_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-6")
      end
    end

    context "when the air pollution level is 7" do
      let(:air_pollution_level) { 7 }

      it "returns _daqi-level-7_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-7")
      end
    end

    context "when the air pollution level is 8" do
      let(:air_pollution_level) { 8 }

      it "returns _daqi-level-8_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-8")
      end
    end

    context "when the air pollution level is 9" do
      let(:air_pollution_level) { 9 }

      it "returns _daqi-level-9_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-9")
      end
    end

    context "when the air pollution level is 10" do
      let(:air_pollution_level) { 10 }

      it "returns _daqi-level-10_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-10")
      end
    end
  end

  describe "icon_stroke_colour_class" do
    let(:component) {
      forecast = FactoryBot.build(:forecast, air_pollution: FactoryBot.build(:air_pollution_prediction, level))
      DayTabComponent.new(forecast: forecast, active_date: Date.today)
    }

    context "when the air pollution label is _Very high_" do
      let(:level) { :very_high }

      it "returns _stroke-white_" do
        expect(component.icon_stroke_colour_class).to eq("stroke-white")
      end
    end

    context "when the air pollution label is _High_" do
      let(:level) { :high }

      it "returns _stroke-white_" do
        expect(component.icon_stroke_colour_class).to eq("stroke-white")
      end
    end

    context "when the air pollution label is _Moderate_" do
      let(:level) { :moderate }

      it "returns _stroke-black_" do
        expect(component.icon_stroke_colour_class).to eq("stroke-black")
      end
    end
  end
end
