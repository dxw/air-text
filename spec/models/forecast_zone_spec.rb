RSpec.describe ForecastZone do
  describe "#type" do
    let(:borough) { ForecastZone.new(type: 1, name: double, id: double) }
    let(:area) { ForecastZone.new(type: 2, name: double, id: double) }

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
