# frozen_string_literal: true

RSpec.describe DayTabComponent, type: :component do
  describe "daqi_indicator_colour_class" do
    let(:component) {
      DayTabComponent.new(forecast: FactoryBot.build(:forecast, air_pollution_level: air_pollution_level), active_date: Date.today)
    }

    context "when the air pollution level is 1" do
      let(:air_pollution_level) { 1 }

      it "returns _daqi-level-1_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-1 daqi-label-low")
      end
    end

    context "when the air pollution level is 2" do
      let(:air_pollution_level) { 2 }

      it "returns _daqi-level-2_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-2 daqi-label-low")
      end
    end

    context "when the air pollution level is 3" do
      let(:air_pollution_level) { 3 }

      it "returns _daqi-level-3_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-3 daqi-label-low")
      end
    end

    context "when the air pollution level is 4" do
      let(:air_pollution_level) { 4 }

      it "returns _daqi-level-4_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-4 daqi-label-moderate")
      end
    end

    context "when the air pollution level is 5" do
      let(:air_pollution_level) { 5 }

      it "returns _daqi-level-5_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-5 daqi-label-moderate")
      end
    end

    context "when the air pollution level is 6" do
      let(:air_pollution_level) { 6 }

      it "returns _daqi-level-6_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-6 daqi-label-moderate")
      end
    end

    context "when the air pollution level is 7" do
      let(:air_pollution_level) { 7 }

      it "returns _daqi-level-7_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-7 daqi-label-high")
      end
    end

    context "when the air pollution level is 8" do
      let(:air_pollution_level) { 8 }

      it "returns _daqi-level-8_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-8 daqi-label-high")
      end
    end

    context "when the air pollution level is 9" do
      let(:air_pollution_level) { 9 }

      it "returns _daqi-level-9_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-9 daqi-label-high")
      end
    end

    context "when the air pollution level is 10" do
      let(:air_pollution_level) { 10 }

      it "returns _daqi-level-10_" do
        expect(component.daqi_indicator_colour_class).to eq("daqi-level-10 daqi-label-very-high")
      end
    end
  end
end
