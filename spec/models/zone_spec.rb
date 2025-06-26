RSpec.describe Zone do
  describe "associations" do
    it { should belong_to(:zone_group) }
  end

  describe "::default" do
    it "returns Central London zone record" do
      expect(Zone.default.cerc_id).to eq(Zone::DEFAULT_ZONE_CENTRAL_LONDON_CERC_ID)
    end
  end
end
