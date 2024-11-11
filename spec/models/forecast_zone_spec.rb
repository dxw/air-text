RSpec.describe ForecastZone do
  describe "#type" do
    let(:borough) { FactoryBot.build(:forecast_zone, type: 1) }
    let(:area) { FactoryBot.build(:forecast_zone, type: 2) }

    context "when set to 1" do
      it "returns the label 'London Borough'" do
        expect(borough.type).to eq("London Borough")
      end
    end

    context "when set to 2" do
      it "returns the label 'Area'" do
        expect(area.type).to eq("Area")
      end
    end
  end
end
