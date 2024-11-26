# frozen_string_literal: true

RSpec.feature "Forecasts page - hsaring", feature: true do
  include Features::ForecastHelper

  let(:forecasts) do
    [
      Fixtures::API.zone_forecast(day: :today),
      Fixtures::API.zone_forecast(day: :tomorrow),
      Fixtures::API.zone_forecast(day: :day_after_tomorrow)
    ]
  end

  before do
    stub_cerc_api_with(forecasts)
  end

  describe "Sharing forecasts" do
    # When I click on the share button
    # Then I see the share icons for multiple platforms

    it "shows share icons for multiple platforms" do
      view_forecasts

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
        view_forecasts

        click_on "Share with others"
      end

      describe "Sharing to WhatsApp" do
        it "shares the forecast to WhatsApp" do
          click_on "WhatsApp"
          expect(page.current_url).to match(%r{https://wa.me/\?text=#{share_message}})
        end
      end

      describe "Sharing to X / Twitter" do
        it "shares the forecast to Twitter" do
          click_on "X / Twitter"
          expect(page.current_url).to match(%r{https://x.com/intent/tweet\?text=#{share_message}})
        end
      end

      describe "Sharing to Bluesky" do
        it "shares the forecast to Bluesky" do
          click_on "Bluesky"
          expect(page.current_url).to match(%r{https://bsky.app/intent/compose\?text=#{share_message}})
        end
      end

      describe "Sharing to Facebook" do
        it "shares the link to Facebook" do
          click_on "Facebook"
          expect(page.current_url).to match(%r{https://facebook.com/sharer/sharer.php\?u=http://www.example.com/forecast})
        end
      end

      describe "Sharing via text message" do
        it "has an sms link" do
          expect(page).to have_link(nil, href: "sms:;?&body=#{share_message}")
        end
      end

      describe "Sharing via email" do
        it "has a mailto link" do
          expect(page).to have_link(nil, href: "mailto:?body=#{share_message}&subject=Air%20quality%20forecast")
        end
      end
    end
  end
end
