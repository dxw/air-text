RSpec.describe VerificationCode do
  describe "#expired?" do
    let(:verification_code) { VerificationCode.new(expires_at: expires_at) }

    context "when expires_at is in the past" do
      let(:expires_at) { 1.hour.ago }

      it "returns true" do
        expect(verification_code.expired?).to be_truthy
      end
    end

    context "when expires_at is in the future" do
      let(:expires_at) { 1.hour.from_now }

      it "returns false" do
        expect(verification_code.expired?).to be_falsey
      end
    end
  end

  describe ".generate" do
    it "creates a new verification code for the target that expires in 1 hour" do
      expect { VerificationCode.generate("target") }.to change { VerificationCode.count }.by(1)
      expect(VerificationCode.last.target).to eq(VerificationCode.digest("target"))
      expect(VerificationCode.last.expires_at).to be_within(1.second).of(1.hour.from_now)
    end
  end

  describe ".remove_expired" do
    it "removes expired verification codes" do
      VerificationCode.create!(expires_at: 1.hour.ago)
      VerificationCode.create!(expires_at: 1.hour.from_now)

      expect { VerificationCode.remove_expired }.to change { VerificationCode.count }.by(-1)
    end
  end
end
