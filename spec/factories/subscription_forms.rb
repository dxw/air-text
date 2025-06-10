FactoryBot.define do
  factory :subscription_creation_form do
    trait :contact_details_email do
      current_step { "contact_details" }
      receive_email { "1" }
      receive_sms { "0" }
      receive_voice { "0" }
      email { "joseph@dxw.com" }
      sms_number { "" }
      voice_number { "" }
    end

    trait :contact_details_sms do
      current_step { "contact_details" }
      receive_email { "0" }
      receive_sms { "1" }
      receive_voice { "0" }
      email { "" }
      sms_number { "0123456789" }
      voice_number { "" }
    end

    trait :contact_details_voice do
      current_step { "contact_details" }
      receive_email { "0" }
      receive_sms { "0" }
      receive_voice { "1" }
      email { "" }
      sms_number { "" }
      voice_number { "0123456789" }
    end

    trait :email_verification do
      contact_details_email
      current_step { "email_verification" }
    end

    trait :sms_verification do
      contact_details_sms
      current_step { "sms_verification" }
    end

    trait :sms_verification do
      contact_details_sms
      current_step { "sms_verification" }
    end

    trait :zone_selection do
      email_verification
      current_step { "zone_selection" }
      zone_search { "" }
      zones { ["Central London"] }
    end

    trait :time_selection do
      zone_selection
      current_step { "time_selection" }
      time { "AM" }
    end

    trait :wrap_up do
      time_selection
      current_step { "wrap_up" }
      reason { "" }
      source { "" }
      research { "" }
      terms { "1" }
      privacy { "1" }
    end

    trait :confirmation do
      wrap_up
      current_step { "confirmation" }
    end

    initialize_with { new(**attributes) }
  end
end
