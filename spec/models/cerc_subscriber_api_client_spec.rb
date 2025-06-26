RSpec.describe CercSubscriberApiClient do
  around do |example|
    env_vars = {
      CERC_SUBSCRIBER_API_HOST_URL: "https://example.com",
      CERC_SUBSCRIBER_API_KEY: "ABC123"
    }
    ClimateControl.modify(env_vars) { example.run }
  end

  describe ".find_subscriber" do
    let(:email) { "name@example.com" }
    let(:phone) { "555-555-5555" }

    it "makes a GET request to the find-subscriber endpoint" do
      query = {email: email, phone: phone}

      expect(CercSubscriberApiClient).to receive(:request).with("find-subscriber", :get, query)

      CercSubscriberApiClient.find_subscriber(email: email, phone: phone)
    end
  end

  describe ".send_verification_code" do
    let(:medium) { "email" }
    let(:verification_code) { "ABC123" }
    let(:email) { "name@example.com" }
    let(:phone) { "555-555-5555" }

    it "makes a POST request to the send-verification-code endpoint" do
      query = {
        medium: medium,
        verificationCode: verification_code,
        expiryString: "15 minutes",
        email: email,
        phone: phone
      }
      expect(CercSubscriberApiClient).to receive(:request).with("send-verification-code", :post, query)
      CercSubscriberApiClient.send_verification_code(medium: medium, verification_code: verification_code, email: email, phone: phone)
    end
  end

  describe ".get_subscriptions" do
    let(:subscriber_id) { 123 }

    it "makes a GET request to the subscriptions/:subscriber_id endpoint" do
      expect(CercSubscriberApiClient).to receive(:request).with("subscriptions/#{subscriber_id}", :get)

      CercSubscriberApiClient.get_subscriptions(subscriber_id)
    end
  end

  describe ".create_subscription" do
    let(:email) { "name@example.com" }
    let(:phone) { "555-555-5555" }
    let(:zone) { "zone" }
    let(:medium) { "medium" }
    let(:ampm) { "ampm" }
    let(:subscriber_id) { 123 }
    let(:subscriber_details) { {} }

    it "makes a POST request to the subscriptions endpoint" do
      query = {
        subscriberId: subscriber_id,
        zone: zone,
        mode: medium,
        phone: phone,
        email: email,
        ampm: ampm,
        subscriberDetails: subscriber_details
      }

      expect(CercSubscriberApiClient).to receive(:request).with("subscriptions", :post, query)

      CercSubscriberApiClient.create_subscription(subscriber_id: subscriber_id, zone: zone, medium: medium, ampm: ampm, phone: phone, email: email, subscriber_details: subscriber_details)
    end
  end

  describe ".delete_subscription" do
    it "makes a DELETE request to the subscriptions endpoint" do
      subscriber_id = 123
      subscription_id = 456
      query = {subscriberId: subscriber_id, subscriptionId: subscription_id}

      expect(CercSubscriberApiClient).to receive(:request).with("subscriptions", :delete, query)

      CercSubscriberApiClient.delete_subscription(subscriber_id, subscription_id)
    end
  end

  describe ".request" do
    it "makes a GET request to the base_url and endpoint" do
      endpoint = "find-subscriber"

      expect(HTTParty).to receive(:get).with("https://example.com/#{endpoint}", headers: {"x-api-key" => "ABC123"}, query: {})

      CercSubscriberApiClient.send(:request, endpoint, :get)
    end

    it "makes a POST request to the base_url and endpoint" do
      endpoint = "subscriptions"

      expect(HTTParty).to receive(:post).with("https://example.com/#{endpoint}", headers: {"x-api-key" => "ABC123"}, body: nil, query: {})

      CercSubscriberApiClient.send(:request, endpoint, :post)
    end
  end
end
