RSpec.describe ForecastsController do
  describe "GET :index" do
    it "renders the _index_ template" do
      get :index

      expect(response).to render_template("index")
    end
  end
end
