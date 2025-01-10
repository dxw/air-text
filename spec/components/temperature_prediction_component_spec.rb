# frozen_string_literal: true

RSpec.describe TemperaturePredictionComponent, type: :component do
  include Components::PredictionHelper

  let(:value) {
    {
      min: -2,
      max: 8
    }
  }
  let(:component) { TemperaturePredictionComponent.new(value) }

  before { render_inline(component) }

  describe "class" do
    it "renders the prediction with the class temperature" do
      expect(page).to have_css(".prediction.temperature")
    end
  end

  describe "#name" do
    it "renders the #name in .name" do
      expect(page).to have_css(".name", text: "Temperature")
    end
  end

  describe "#display_value" do
    it "renders the temperature range in Celsius and Farenheit in .display-value" do
      text = page.find(".display-value").text.gsub(/\p{Space}/, " ") # Replace non-breaking space with regular space
      expect(text).to eq("-2 to 8°C / 28 to 46°F")
    end
  end

  describe "guidance" do
    describe "visibility" do
      context "when the temperate is normal" do
        let(:value) {
          {
            min: 10,
            max: 20
          }
        }

        it "does not show the panel" do
          expect(page).not_to have_css(".temperature .guidance")
        end
      end

      context "when the temperature is very cold" do
        let(:value) {
          {
            min: -10,
            max: -5
          }
        }

        it "shows the guidance for low temperatures" do
          expect(page).to have_css(".temperature .guidance.bg-high-alert-guidance-panel", text: ActionView::Base.full_sanitizer.sanitize(health_guidance(:temperature, :low_temp).first[:html]))
        end
      end

      context "when the temperature is very hot" do
        let(:value) {
          {
            min: 30,
            max: 35
          }
        }

        it "shows the guidance for high temperatures" do
          expect(page).to have_css(".temperature .guidance.bg-high-alert-guidance-panel", text: ActionView::Base.full_sanitizer.sanitize(health_guidance(:temperature, :high_temp).first[:html]))
        end
      end
    end
  end
end
