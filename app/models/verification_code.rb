class VerificationCode < ApplicationRecord
  def expired?
    expires_at < Time.current
  end

  class << self
    def generate(target)
      where(target: digest(target)).destroy_all
      create!({
        code: new_code,
        expires_at: 1.hour.from_now,
        target: digest(target)
      })
    end

    def remove_expired
      where("expires_at < ?", Time.current).destroy_all
    end

    def verify(inputted_code, inputted_target)
      return false if inputted_code.blank? || inputted_target.blank?

      verification_code = find_by(target: digest(inputted_target))

      return false if verification_code.nil? || verification_code.expired?

      digest(inputted_target) == verification_code.target && inputted_code == verification_code.code
    end

    def new_code
      SecureRandom.hex(3).upcase
    end

    def digest(target)
      OpenSSL::HMAC.hexdigest("SHA256", ENV.fetch("SECRET_KEY"), target)
    end
  end
end
