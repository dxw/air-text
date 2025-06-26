# frozen_string_literal: true

RSpec.feature "Subscribing to alerts", js: true do
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

  describe "Subscribing to alerts" do
    it "shows a form when I click on the subscribe button" do
      visit root_path

      click_on "Sign up to get free alerts"

      expect(page).to have_text("Air pollution alert service")
      expect(page).to have_text("Choose how you’d like to receive your alerts")
    end

    it "is accessible" do
      visit root_path
      expect(page).to be_accessible
    end
  end

  describe "Subscribing to alerts" do
    describe "Contact details" do
      before do
        visit subscriptions_path(id: :contact_details)
      end

      it "is accessible" do
        expect(page).to be_accessible
      end

      it "shows the email field when I select the email option" do
        expect(page).not_to have_field("Email", type: "email")

        check "Email"

        expect(page).to have_field("Email", type: "email")
      end

      it "shows the mobile number field when I select the text option" do
        expect(page).not_to have_field("Mobile number")

        check "Text message"

        expect(page).to have_field("Mobile number")
      end

      it "shows the phone number field when I select the voicemail option" do
        expect(page).not_to have_field("Phone number")

        check "Voicemail"

        expect(page).to have_field("Phone number")
      end

      describe "Validating the form" do
        it "shows an error if I don't select any options" do
          click_on "Next"

          expect(page).to have_text("You must select at least one contact method")
        end

        it "shows an error if I select email, but don't provide an email address" do
          check "Email"
          click_on "Next"

          expect(page).to have_text("You must provide an email address")
        end

        it "shows an error if I select text, but don't provide a mobile number" do
          check "Text message"
          click_on "Next"

          expect(page).to have_text("You must provide a mobile number")
        end

        it "shows an error if I select voicemail, but don't provide a phone number" do
          check "Voicemail"
          click_on "Next"

          expect(page).to have_text("You must provide a phone number")
        end

        it "does not show an error if I select email and provide an email address" do
          check "Email"
          fill_in "Email", with: "hello@example.com"
          click_on "Next"

          expect(page).to have_text("Verify your email address")
        end
      end
    end

    describe "Contact verification" do
      describe "Email verification" do
        before do
          fill_form_up_to(:contact_details_email)
          visit subscriptions_path(id: :email_verification)
        end

        it "is accessible" do
          expect(page).to be_accessible
        end

        context "when I enter the correct verification code" do
          let(:code) { "123456" }

          before do
            allow(VerificationCode).to receive(:new_code).and_return(code)
            visit subscriptions_path(id: :email_verification)
          end

          it "lets me proceed" do
            fill_in_verification_code(:email, code)
            click_on "Next"

            expect(page).to have_text("Your email is now verified")
          end
        end

        context "when I enter an expired verification code" do
          let(:code) { "123456" }

          before do
            allow(VerificationCode).to receive(:new_code).and_return(code)
            allow_any_instance_of(VerificationCode).to receive(:expired?).and_return(true)
            visit subscriptions_path(id: :email_verification)
          end

          it "shows an error" do
            fill_in_verification_code(:email, code)
            click_on "Next"

            expect(page).to have_text("The verification code you entered is incorrect")
          end
        end

        context "when I don't enter a verification code" do
          it "shows an error" do
            click_on "Next"

            expect(page).to have_text("You must enter the verification code")
          end
        end

        context "when I enter the wrong verification code" do
          it "shows an error" do
            fill_in_verification_code(:email, "000000")
            click_on "Next"

            expect(page).to have_text("The verification code you entered is incorrect")
          end
        end

        context "when I request a new verification code" do
          it "sends a new verification code" do
            allow(VerificationCode).to receive(:generate).and_call_original
            click_on "resend the code"

            expect(page).to have_text("sent successfully")
            expect(VerificationCode).to have_received(:generate).with(@subscription_form.email)
          end
        end

        context "when verification is disabled" do
          it "lets me proceed without entering a verification code" do
            ClimateControl.modify VERIFICATION_ENABLED: "false" do
              click_on "Next"

              expect(page).to have_text("Your email is now verified")
            end
          end
        end
      end

      describe "SMS number verification" do
        before do
          fill_form_up_to(:contact_details_sms)
          visit subscriptions_path(id: :sms_number_verification)
        end

        it "is accessible" do
          expect(page).to be_accessible
        end

        context "when I enter the correct verification code" do
          let(:code) { "123456" }

          before do
            allow(VerificationCode).to receive(:new_code).and_return(code)
            visit subscriptions_path(id: :sms_number_verification)
          end

          it "lets me proceed" do
            fill_in_verification_code(:sms_number, code)
            click_on "Next"

            expect(page).to have_text("Your phone number is now verified")
          end
        end

        context "when I don't enter a verification code" do
          it "shows an error" do
            click_on "Next"

            expect(page).to have_text("You must enter the verification code")
          end
        end

        context "when I enter the wrong verification code" do
          it "shows an error" do
            fill_in_verification_code(:sms_number, "000000")
            click_on "Next"

            expect(page).to have_text("The verification code you entered is incorrect")
          end
        end

        context "when I request a new verification code" do
          it "sends a new verification code" do
            allow(VerificationCode).to receive(:generate).and_call_original
            click_on "resend the code"

            expect(page).to have_text("sent successfully")
            expect(VerificationCode).to have_received(:generate).with(@subscription_form.sms_number)
          end
        end
      end

      describe "Voicemail number verification" do
        before do
          fill_form_up_to(:contact_details_voice)
          visit subscriptions_path(id: :voice_number_verification)
        end

        it "is accessible" do
          expect(page).to be_accessible
        end

        context "when I enter the correct verification code" do
          let(:code) { "123456" }

          before do
            allow(VerificationCode).to receive(:new_code).and_return(code)
            visit subscriptions_path(id: :voice_number_verification)
          end

          it "lets me proceed" do
            fill_in_verification_code(:voice_number, code)
            click_on "Next"

            expect(page).to have_text("Your phone number is now verified")
          end
        end

        context "when I don't enter a verification code" do
          it "shows an error" do
            click_on "Next"

            expect(page).to have_text("You must enter the verification code")
          end
        end

        context "when I enter the wrong verification code" do
          it "shows an error" do
            fill_in_verification_code(:voice_number, "000000")
            click_on "Next"

            expect(page).to have_text("The verification code you entered is incorrect")
          end
        end

        context "when I request a new verification code" do
          it "sends a new verification code" do
            allow(VerificationCode).to receive(:generate).and_call_original
            click_on "resend the code"

            expect(page).to have_text("sent successfully")
            expect(VerificationCode).to have_received(:generate).with(@subscription_form.voice_number)
          end
        end
      end
    end

    describe "Zone selection" do
      before do
        Billy.config.record_stub_requests = true
        fill_form_up_to(:email_verification)
        visit subscriptions_path(id: :zone_selection)
      end

      let(:st_pauls_response) do
        {
          "type" => "FeatureCollection",
          "features" => [
            {
              "type" => "Feature",
              "properties" => {
                "ref" => "osm =>w369161987",
                "country_code" => "gb",
                "wikidata" => "Q173882",
                "categories" => [
                  "attraction",
                  "cathedral",
                  "place of worship"
                ]
              },
              "geometry" => {
                "type" => "Point",
                "coordinates" => [
                  -0.09845067545739992,
                  51.51378719266546
                ]
              },
              "bbox" => [
                -0.09845067545739992,
                51.51378719266546,
                -0.09845067545739992,
                51.51378719266546
              ],
              "center" => [
                -0.09845067545739992,
                51.51378719266546
              ],
              "place_name" => "St Paul's Cathedral, Cheap, City of London, United Kingdom",
              "place_type" => [
                "poi"
              ],
              "relevance" => 1,
              "id" => "poi.28251191",
              "text" => "St Paul's Cathedral"
            }
          ],
          "query" => [
            "st",
            "pauls",
            "cathedral"
          ],
          "attribution" => "<a href=\"https =>//www.maptiler.com/copyright/\" target=\"_blank\">&copy; MapTiler</a> <a href=\"https =>//www.openstreetmap.org/copyright\" target=\"_blank\">&copy; OpenStreetMap contributors</a>"
        }
      end

      it "is accessible" do
        expect(page).to be_accessible
      end

      describe "Searching for zones" do
        before do
          stub_maptiler_geocoding(search: search_term, response: response)
        end

        context "when I search for a location within the zones" do
          let(:search_term) { "St Pauls" }
          let(:response) { st_pauls_response }

          it "shows a list of zones when I search for a location" do
            search_for_location("St Pauls")

            within "#search-results" do
              expect(page).to have_text("City of London")
              expect(page).to have_text("Central London")
            end
          end

          it "adds a zone when I click on the search result" do
            search_for_location("St Pauls")

            within "#search-results" do
              find("li", text: "Central London").click
            end

            find("h4", text: /\ALondon\z/).click # to expand details tag
            expect(page).to have_checked_field("Central London")
          end
        end

        context "when I search for a location outside the zones" do
          let(:search_term) { "York" }
          let(:response) do
            {
              type: "FeatureCollection",
              features: [
                {
                  type: "Feature",
                  properties: {
                    ref: "osm:n4205059843",
                    country_code: "gb",
                    wikidata: "Q8055506",
                    categories: [
                      "police"
                    ]
                  },
                  geometry: {
                    type: "Point",
                    coordinates: [
                      -1.0815246775746346,
                      53.962439180387925
                    ]
                  },
                  bbox: [
                    -1.0815246775746346,
                    53.962439180387925,
                    -1.0815246775746346,
                    53.962439180387925
                  ],
                  center: [
                    -1.0815246775746346,
                    53.962439180387925
                  ],
                  place_name: "Minster Police Office, York, York, United Kingdom",
                  place_type: [
                    "poi"
                  ],
                  relevance: 1,
                  id: "poi.7063901",
                  text: "Minster Police Office",
                  matching_text: "York Minster",
                  matching_place_name: "York Minster, York, York, United Kingdom"
                }
              ],
              query: [
                "york"
              ],
              attribution: "<a href=\"https://www.maptiler.com/copyright/\" target=\"_blank\">&copy; MapTiler</a> <a href=\"https://www.openstreetmap.org/copyright\" target=\"_blank\">&copy; OpenStreetMap contributors</a>"
            }
          end

          it "shows a message if no zones are found" do
            search_for_location("York")

            within "#search-results" do
              expect(page).to have_text("No results found within the area covered by airTEXT")
            end
          end
        end
      end

      describe "Selecting zones manually" do
        it "adds a zone when I check the checkbox" do
          find("summary", text: /\ALondon\z/).click
          check "Central London"

          within "#zone-tags" do
            expect(page).to have_text("Central London")
          end
        end
      end

      describe "Validating the form" do
        before do
          visit subscriptions_path(id: :zone_selection)
        end

        it "shows an error if I don't select any zones" do
          click_on "Next"

          expect(page).to have_text("You must select at least one zone to receive alerts for")
        end

        it "shows an error if I select more than 5 zones" do
          find("summary", text: /\ALondon\z/).click
          check "Central London"
          check "City of London"
          check "Westminster"
          check "Camden"
          check "Islington"
          check "Hackney"
          click_on "Next"

          expect(page).to have_text("You can select a maximum of 5 zones")
        end

        it "does not show an error if I select a zone" do
          find("summary", text: /\ALondon\z/).click
          check "Central London"
          click_on "Next"

          expect(page).to have_text("Select your preferred time to receive alerts")
        end
      end
    end

    describe "Time selection" do
      before do
        fill_form_up_to(:zone_selection)
        visit subscriptions_path(id: :time_selection)
      end

      it "is accessible" do
        expect(page).to be_accessible
      end

      describe "Validating the form" do
        it "shows an error if I don't select a time" do
          click_on "Next"

          expect(page).to have_text("You must select a time to receive alerts")
        end

        it "does not show an error if I select a time" do
          choose "Morning: 7am"
          click_on "Next"

          expect(page).to have_text("Would you like to help us improve the airTEXT service?")
        end
      end
    end

    describe "Wrap up" do
      before do
        fill_form_up_to(:time_selection)
        visit subscriptions_path(id: :wrap_up)
      end

      it "is accessible" do
        expect(page).to be_accessible
      end

      describe "Validating the form" do
        it "shows an error if I don't accept the terms" do
          click_on "Next"

          expect(page).to have_text("You must agree to the terms and conditions")
        end

        it "shows an error if I don't accept the privacy policy" do
          click_on "Next"

          expect(page).to have_text("You must agree to the privacy policy")
        end

        it "does not show an error if I accept the terms and privacy policy" do
          check "subscription_form_terms"
          check "subscription_form_privacy"
          click_on "Next"

          expect(page).to have_text("Your air pollution alert preferences")
        end
      end
    end

    describe "Confirmation" do
      before do
        fill_form_up_to(:wrap_up)
        visit subscriptions_path(id: :confirmation)
        allow(CercSubscriberApiClient).to receive(:create_subscription).and_return(true)
      end

      it "is accessible" do
        expect(page).to be_accessible
      end

      it "shows the confirmation page" do
        expect(page).to have_text("Your air pollution alert preferences")
      end

      it "shows a success message when the form is submitted" do
        click_on "Submit"

        expect(page).to have_text("You are now subscribed to receive air pollution alerts.")
      end
    end
  end
end

def search_for_location(location)
  fill_in "subscription_form_zone_search", with: location
end

def fill_form_up_to(step)
  allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_wrap_original do |original_method, *args|
    session_data = original_method.call(*args)
    @subscription_form = FactoryBot.build(:subscription_form, step)
    session_data[:subscription_form] ||= @subscription_form.attributes
    session_data
  end
end

def fill_in_verification_code(mode, code)
  page.all("[name='subscription_form[verification_code_#{mode}][]']").each_with_index do |input, index|
    input.fill_in with: code.slice(index)
  end
end

def stub_maptiler_geocoding(search:, response:)
  proxy.stub("https://api.maptiler.com:443/geocoding/#{CGI.escape_uri_component(search)}.json")
    .and_return(
      headers: {"Access-Control-Allow-Origin" => "*"},
      json: response
    )
end
