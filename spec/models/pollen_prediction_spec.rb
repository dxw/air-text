RSpec.describe PollenPrediction do
  describe "#daqi_label and #guidance" do
    let(:prediction) { FactoryBot.build(:pollen_prediction, value: value) }
    let(:value) { 1 }

    it "returns the guidance for the level" do
      expect(prediction.daqi_label).to eq("Low")
      expect(prediction.guidance).to eq(I18n.t("prediction.guidance.pollen.low"))
    end

    context "when the value is -999" do
      let(:value) { -999 }

      it "returns low" do
        expect(prediction.daqi_label).to eq("Low")
        expect(prediction.guidance).to eq(I18n.t("prediction.guidance.pollen.low"))
      end
    end
  end
end
