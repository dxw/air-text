# frozen_string_literal: true

require "rails_helper"

RSpec.describe PredictionComponent, type: :component do
  let(:prediction) {
    OpenStruct.new(
      name: "Solar Rays",
      daqi_level: :moderate
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

    it "includes an indicator with the level as a class" do
      expect(page).to have_css(".daqi-indicator.moderate", text: "●")
    end
  end
end
