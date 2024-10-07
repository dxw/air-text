RSpec.describe UvPrediction do
  describe "#label_text" do
    context "when the UV level is 1, 2 or 3" do
      [1, 2, 3].each do |value|
        prediction = UvPrediction.new(value)
        it "returns _Low_ with guidance" do
          expect(prediction.label).to eq("Low")
          expect(prediction.guidance).to eq("No action required. You can safely stay outside.")
        end
      end
    end

    context "when the UV level is between 4 and 6" do
      [4, 5, 6].each do |value|
        prediction = UvPrediction.new(value)
        it "returns _Moderate_ with guidance" do
          expect(prediction.label).to eq("Moderate")
          expect(prediction.guidance).to eq("Protection required. Seek shade during midday hours, cover up and wear suncream.")
        end
      end
    end

    context "when the UV level is between 7 and 9" do
      [7, 8, 9].each do |level|
        prediction = UvPrediction.new(level)
        it "returns _High_ with guidance" do
          expect(prediction.label).to eq("High")
          expect(prediction.guidance).to eq("some high UV guidance")
        end
      end
    end

    context "when the UV level is 10" do
      prediction = UvPrediction.new(10)
      it "returns _Very high_ with guidance" do
        expect(prediction.label).to eq("Very high")
        expect(prediction.guidance).to eq("some very high UV guidance")
      end
    end
  end
end
