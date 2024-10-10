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

  describe "#daqi_indicator_colour" do
    context "when the daqi level is low" do
      let(:component) {
        PredictionComponent.new(
          prediction: OpenStruct.new(daqi_level: :low)
        )
      }

      it "uses a green colour" do
        expect(component.daqi_indicator_colour).to match(/green/)
      end
    end

    context "when the daqi level is moderate" do
      let(:component) {
        PredictionComponent.new(
          prediction: OpenStruct.new(daqi_level: :moderate)
        )
      }
      it "uses an amber colour" do
        expect(component.daqi_indicator_colour).to match(/amber/)
      end
    end

    context "when the daqi level is high" do
      let(:component) {
        PredictionComponent.new(
          prediction: OpenStruct.new(daqi_level: :high)
        )
      }

      it "uses a red colour" do
        expect(component.daqi_indicator_colour).to match(/red/)
      end
    end

    context "when the daqi level is very high" do
      let(:component) {
        PredictionComponent.new(
          prediction: OpenStruct.new(daqi_level: :very_high)
        )
      }

      it "uses a black-ish" do
        expect(component.daqi_indicator_colour).to match(/stone/)
      end
    end

    context "when the daqi level is not known" do
      let(:component) {
        PredictionComponent.new(
          prediction: OpenStruct.new(daqi_level: :unknown)
        )
      }

      it "raises an error" do
        expect { component.daqi_indicator_colour }.to raise_error(/DAQI level 'unknown' not known/)
      end
    end
  end

  describe "daqi-level" do
    it "adds the DAQI level as a class on the wrapper" do
      expect(page).to have_css(".prediction.moderate")
    end

    it "includes an indicator with the level as a class" do
      expect(page).to have_css(".daqi-indicator.moderate", text: "●")
    end

    it "includes the daqi_indicator_colour as a class" do
      component = PredictionComponent.new(prediction: prediction)
      expect(page).to have_css(".#{component.daqi_indicator_colour}.daqi-indicator", text: "●")
    end
  end

  describe "daqi-label" do
    it "includes the prediction's #daqi_label in .daqi-label" do
      expect(page).to have_css(".daqi-label", text: "Moderate")
    end
  end

  describe "details" do
    it "includes the prediction's #value as .daqi-value" do
      expect(page).to have_css(".details .daqi-value", text: "Index 5/10")
    end

    it "includes the prediction's guidance from the translation system" do
      expect(page).to have_css(
        ".details .guidance",
        text: I18n.t("prediction.guidance.solar_rays.moderate")
      )
    end

    it "includes the details_panel_colour as a class" do
      component = PredictionComponent.new(prediction: prediction)
      expect(page).to have_css(".#{component.details_panel_colour}.details")
    end

    describe "the colour of the details panel (#details_panel_colour)" do
      context "when the daqi level is low" do
        let(:component) {
          PredictionComponent.new(
            prediction: OpenStruct.new(daqi_level: :low)
          )
        }
        it "uses an green colour" do
          expect(component.details_panel_colour).to match(/green/)
        end
      end

      context "when the daqi level is moderate" do
        let(:component) {
          PredictionComponent.new(
            prediction: OpenStruct.new(daqi_level: :moderate)
          )
        }
        it "uses an amber colour" do
          expect(component.details_panel_colour).to match(/amber/)
        end
      end

      context "when the daqi level is high" do
        let(:component) {
          PredictionComponent.new(
            prediction: OpenStruct.new(daqi_level: :high)
          )
        }

        it "uses a red colour" do
          expect(component.details_panel_colour).to match(/red/)
        end
      end

      context "when the daqi level is very high" do
        let(:component) {
          PredictionComponent.new(
            prediction: OpenStruct.new(daqi_level: :very_high)
          )
        }

        it "uses a black-ish" do
          expect(component.details_panel_colour).to match(/stone/)
        end
      end

      context "when the daqi level is not known" do
        let(:component) {
          PredictionComponent.new(
            prediction: OpenStruct.new(daqi_level: :unknown)
          )
        }

        it "raises an error" do
          expect { component.details_panel_colour }.to raise_error(/DAQI level 'unknown' not known/)
        end
      end
    end
  end
end
