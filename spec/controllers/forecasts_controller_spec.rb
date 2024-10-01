RSpec.describe ForecastsController do
  describe "GET :show" do
    it "renders the _show_ template" do
      allow(CercApiClient).to receive(:fetch_data).and_return({body: File.read("#{Rails.root}/public/sample-forecast.json")})

      get :show

      expect(CercApiClient).to have_received(:fetch_data).with("Southwark")
      expect(response).to render_template("show")
    end
  end
end
