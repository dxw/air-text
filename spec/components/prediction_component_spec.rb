# frozen_string_literal: true

require "rails_helper"

RSpec.describe PredictionComponent, type: :component do
  let(:prediction) {
    OpenStruct.new(
      name: "Solar Rays",
      daqi_level: :moderate,
      daqi_label: "Moderate",
      value: 5
    )
  }

  before { render_inline(PredictionComponent.new(prediction: prediction)) }

  describe "#name" do
    it "adds the name of the prediction as a class to the wrapper" do
      expect(page).to have_css(".prediction.solar-rays")
    end

    it "renders the #name in .name" do
      expect(page).to have_css(".name", text: "Solar Rays")
    end
  end

  describe "daqi-level" do
    it "adds the DAQI level as a class on the wrapper" do
      expect(page).to have_css(".prediction.moderate")
    end
  end

  describe "daqi-label" do
    it "includes the prediction's #daqi_label in .daqi-label" do
      expect(page).to have_css(".daqi-label", text: "Moderate")
    end
  end

  describe "guidance" do
    it "includes the prediction's guidance from the translation system" do
      expect(page).to have_css(
        ".guidance",
        text: I18n.t("prediction.guidance.solar_rays.moderate")
      )
    end

    describe "visibility" do
      context "when the DAQI level is low" do
        let(:component) {
          PredictionComponent.new(
            prediction: OpenStruct.new(name: "Solar Rays", daqi_level: :low, daqi_label: "Low")
          )
        }

        before { render_inline(component) }

        it "hides the panel" do
          expect(page).to have_css(".guidance.hidden")
        end
      end

      context "when the DAQI level is NOT low" do
        [:moderate, :high, :very_high].each do |level|
          let(:component) {
            PredictionComponent.new(
              prediction: OpenStruct.new(name: "Solar Rays", daqi_level: level, daqi_label: level.to_s)
            )
          }

          before { render_inline(component) }

          it "shows the panel" do
            expect(page).to have_css(".guidance.visible")
          end
        end
      end
    end

    it "includes the guidance_panel_colour as a class" do
      component = PredictionComponent.new(prediction: prediction)
      expect(page).to have_css(".#{component.guidance_panel_colour}.guidance")
    end
  end
end
