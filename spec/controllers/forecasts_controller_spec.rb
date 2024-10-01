RSpec.describe ForecastsController do
  describe "GET :show" do
    it "renders the _show_ template" do
      allow(CercApiClient).to receive(:fetch_data)

      get :show

      expect(CercApiClient).to have_received(:fetch_data).with("Southwark").and_return
      expect(response).to render_template("show")
    end
  end
end
