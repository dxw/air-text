RSpec.describe PollenPrediction do
  describe "#valid" do
    let(:prediction) { FactoryBot.build(:pollen_prediction, value: value) }

    context "when the value is -999" do
      let(:value) { -999 }
      it "returns false" do
        expect(prediction.valid?).to eq(false)
      end
    end

    context "when the value is not -999" do
      let(:value) { 1 }
      it "returns true" do
        expect(prediction.valid?).to eq(true)
      end
    end
  end

  describe "#guidance" do
    let(:prediction) { FactoryBot.build(:pollen_prediction, value: value) }
    let(:value) { 1 }

    it "returns the guidance for the level" do
      expect(prediction.guidance).to eq(I18n.t("prediction.guidance.pollen.low"))
    end
  end
end
