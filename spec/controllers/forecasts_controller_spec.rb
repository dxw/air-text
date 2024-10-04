RSpec.describe ForecastsController do
  describe "GET :show" do
    it "renders the _show_ template" do

      expect(response).to render_template("index")
      get :show
    end
  end
end
