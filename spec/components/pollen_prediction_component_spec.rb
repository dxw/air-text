# frozen_string_literal: true

RSpec.describe PollenPredictionComponent, type: :component do
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
      expect(page).to have_css(".name", text: "Pollen")
    end
  end

  describe "guidance" do
    describe "visibility" do
      context "when the level is the null value -999" do
        let(:value) { -999 }

        it "renders the level label in .display-value" do
          expect(page).to have_css(".display-value", text: "Low")
        end

        it "does not show the panel" do
          expect(page).to have_css(".guidance.hidden")
        end
      end

      context "when the level is low" do
        let(:value) { 1 }

        it "renders the level label in .display-value" do
          expect(page).to have_css(".display-value", text: "Low")
        end

        it "does not show the panel" do
          expect(page).to have_css(".guidance.hidden")
        end
      end

      context "when the level is moderate" do
        let(:value) { 5 }

        it "renders the level label in .display-value" do
          expect(page).to have_css(".display-value", text: "Moderate")
        end

        it "shows the prediction's guidance" do
          expect(page).to have_css(".guidance.bg-moderate-alert-guidance-panel.visible", text: component.guidance[:moderate])
        end
      end

      context "when the level is high" do
        let(:value) { 8 }

        it "renders the level label in .display-value" do
          expect(page).to have_css(".display-value", text: "High")
        end

        it "shows the prediction's guidance" do
          expect(page).to have_css(".guidance.bg-high-alert-guidance-panel.visible", text: component.guidance[:high])
        end
      end

      context "when the level is very high" do
        let(:value) { 10 }

        it "renders the level label in .display-value" do
          expect(page).to have_css(".display-value", text: "Very high")
        end

        it "shows the prediction's guidance" do
          expect(page).to have_css(".guidance.bg-very-high-alert-guidance-panel.visible", text: component.guidance[:very_high])
        end
      end
    end
  end
end
