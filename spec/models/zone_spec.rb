RSpec.describe Zone do
  describe "::default" do
    before { FactoryBot.create(:zone, cerc_id: Zone::DEFAULT_ZONE_SOUTHWARK_CERC_ID) }

    it "returns Southwark's Zone record" do
      expect(Zone.default.cerc_id).to eq(Zone::DEFAULT_ZONE_SOUTHWARK_CERC_ID)
    end
  end
end
