# frozen_string_literal: true

require "rails_helper"

RSpec.describe PredictionComponent, type: :component do
  let(:prediction) {
    OpenStruct.new(name: "Solar Rays")
  }

  before { render_inline(PredictionComponent.new(prediction: prediction)) }

  it "renders the #name in .name" do
    expect(page).to have_css(".name", text: "Solar Rays")
  end
end
