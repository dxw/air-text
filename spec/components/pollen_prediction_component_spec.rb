# frozen_string_literal: true

RSpec.describe PollenPredictionComponent, type: :component do
  include Components::PredictionHelper

  let(:value) { 5 }
  let(:component) { PollenPredictionComponent.new(value) }

  before { render_inline(component) }

  describe "class" do
    it "renders the prediction with the class pollen" do
      expect(page).to have_css(".prediction.pollen")
    end
  end

  describe "#name" do
    it "renders the #name in .name" do
      expect(page).to have_css(".pollen .name", text: "Pollen")
    end
  end

  describe "guidance" do
    describe "visibility" do
      context "when the level is the null value -999" do
        let(:value) { -999 }

        it "renders the level label in .display-value" do
          expect(page).to have_css(".pollen .display-value", text: "Low")
        end

        it "does not show the panel" do
          expect(page).not_to have_css(".pollen .guidance")
        end
      end

      context "when the level is low" do
        let(:value) { 1 }

        it "renders the level label in .display-value" do
          expect(page).to have_css(".pollen .display-value", text: "Low")
        end

        it "does not show the panel" do
          expect(page).not_to have_css(".pollen .guidance")
        end
      end

      context "when the level is moderate" do
        let(:value) { 5 }

        it "renders the level label in .display-value" do
          expect(page).to have_css(".pollen .display-value", text: "Moderate")
        end

        it "shows the prediction's guidance" do
          expect(page).to have_css(".pollen .guidance", text: ActionView::Base.full_sanitizer.sanitize(health_guidance(:pollen, :moderate).first[:html]))
        end
      end

      context "when the level is high" do
        let(:value) { 8 }

        it "renders the level label in .display-value" do
          expect(page).to have_css(".pollen .display-value", text: "High")
        end

        it "shows the prediction's guidance" do
          expect(page).to have_css(".pollen .guidance", text: ActionView::Base.full_sanitizer.sanitize(health_guidance(:pollen, :high).first[:html]))
        end
      end

      context "when the level is very high" do
        let(:value) { 10 }

        it "renders the level label in .display-value" do
          expect(page).to have_css(".pollen .display-value", text: "Very high")
        end

        it "shows the prediction's guidance" do
          expect(page).to have_css(".pollen .guidance", text: ActionView::Base.full_sanitizer.sanitize(health_guidance(:pollen, :very_high).first[:html]))
        end
      end
    end
  end
end
