task default: %i[standard spec] if Rails.env.test? || Rails.env.development?

task remove_expired_verification_codes: :environment do
  VerificationCode.remove_expired
end
