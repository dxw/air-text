RSpec.describe MapController do
  describe "GET :show" do
    it "renders the _show_ template" do
      get :show

      expect(response).to render_template("show")
    end
  end
end
