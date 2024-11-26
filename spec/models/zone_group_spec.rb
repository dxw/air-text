RSpec.describe ZoneGroup do
  describe "associations" do
    it { should have_many(:zones) }
  end
end
