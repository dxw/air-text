# frozen_string_literal: true

RSpec.feature "Forecasts page - sharing" do
  include Features::ForecastPageHelper

  let(:forecasts) do
    [
      Fixtures::API.zone_forecast(day: :today),
      Fixtures::API.zone_forecast(day: :tomorrow),
      Fixtures::API.zone_forecast(day: :day_after_tomorrow)
    ]
  end

  before do
    HttpStubs.stub_cerc_api_with(forecasts)
  end

  describe "Sharing forecasts" do
    # When I click on the share button
    # Then I see the share icons for multiple platforms

    it "shows share icons for multiple platforms" do
      visit forecast_path

      click_on "Share with others"

      within(".share-icons") do
        expect(page).to have_text("Copy link")
        expect(page).to have_text("WhatsApp")
        expect(page).to have_text("Text message")
        expect(page).to have_text("Email")
        expect(page).to have_text("X / Twitter")
        expect(page).to have_text("Bluesky")
        expect(page).to have_text("Facebook")
      end
    end

    # When I click on the share button
    # And I click on the WhatsApp icon
    # Then I am taken to the WhatsApp share page"

    describe "Sharing to different platforms" do
      let(:today_forecast) { CachedForecast.all.first.data.first }
      let(:share_message) { CGI.escape_uri_component(today_forecast.share_message) }

      before do
        visit forecast_path

        click_on "Share with others"
      end

      describe "Sharing to WhatsApp" do
        it "has a WhatsApp sharing link" do
          within(:xpath, "//a[contains(@href, 'https://wa.me/?text=#{share_message}')]") do
            expect(page).to have_content("WhatsApp")
          end
        end
      end

      describe "Sharing to X / Twitter" do
        it "has a Twitter sharing link" do
          within(:xpath, "//a[contains(@href, 'https://x.com/intent/tweet?text=#{share_message}')]") do
            expect(page).to have_content("X / Twitter")
          end
        end
      end

      describe "Sharing to Bluesky" do
        it "has a Bluesky sharing link" do
          within(:xpath, "//a[contains(@href, 'https://bsky.app/intent/compose?text=#{share_message}')]") do
            expect(page).to have_content("Bluesky")
          end
        end
      end

      describe "Sharing to Facebook" do
        it "has a Facebook sharing link" do
          within(:xpath, "//a[contains(@href, 'https://facebook.com/sharer/sharer')]") do
            expect(page).to have_content("Facebook")
          end
        end
      end

      describe "Sharing via text message" do
        it "has an sms link" do
          within(:xpath, "//a[contains(@href, 'sms:;?&body=#{share_message}')]") do
            expect(page).to have_content("Text message")
          end
        end
      end

      describe "Sharing via email" do
        it "has a mailto link" do
          within(:xpath, "//a[contains(@href, 'mailto:?body=#{share_message}&subject=Air%20quality%20forecast')]") do
            expect(page).to have_content("Email")
          end
        end
      end
    end
  end
end
