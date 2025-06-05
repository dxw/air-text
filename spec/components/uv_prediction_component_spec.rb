# frozen_string_literal: true

RSpec.describe UvPredictionComponent, type: :component do
  include Components::PredictionHelper

  let(:value) { 3 }
  let(:component) { UvPredictionComponent.new(value) }

  before { render_inline(component) }

  describe "class" do
    it "renders the prediction with the class uv" do
      expect(page).to have_css(".prediction.uv")
    end
  end

  describe "#name" do
    it "renders the #name in .name" do
      expect(page).to have_css(".uv .name", text: "Ultraviolet (UV) rays")
    end
  end

  describe "guidance" do
    describe "visibility" do
      context "when the level is low" do
        let(:value) { 1 }

        describe "#display_value" do
          it "renders the level label in .display-value" do
            expect(page).to have_css(".uv .display-value", text: "Low")
          end
        end

        it "does not show the panel" do
          expect(page).not_to have_css(".uv .guidance")
        end
      end

      context "when the level is moderate" do
        let(:value) { 3 }

        it "renders the level label in .display-value" do
          expect(page).to have_css(".uv .display-value", text: "Moderate")
        end

        it "shows the prediction's guidance" do
          expect(page).to have_css(".uv .guidance", text: ActionView::Base.full_sanitizer.sanitize(health_guidance(:uv, :moderate).first[:html]))
        end
      end

      context "when the level is high" do
        let(:value) { 6 }

        it "renders the level label in .display-value" do
          expect(page).to have_css(".uv .display-value", text: "High")
        end

        it "shows the prediction's guidance" do
          expect(page).to have_css(".uv .guidance", text: ActionView::Base.full_sanitizer.sanitize(health_guidance(:uv, :high).first[:html]))
        end
      end

      context "when the level is very high" do
        let(:value) { 8 }

        it "renders the level label in .display-value" do
          expect(page).to have_css(".uv .display-value", text: "Very high")
        end

        it "shows the prediction's guidance" do
          expect(page).to have_css(".uv .guidance", text: ActionView::Base.full_sanitizer.sanitize(health_guidance(:uv, :very_high).first[:html]))
        end
      end
    end
  end
end
