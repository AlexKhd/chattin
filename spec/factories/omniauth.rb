FactoryGirl.define do
  factory :facebook_auth, class: OmniAuth::AuthHash do

    transient do
      id { SecureRandom.random_number(1_000_000_000).to_s }
      username 'john-doe-fbook'
      name 'Jonh Doe'
      email 'john.doe@example.com'
      token { SecureRandom.urlsafe_base64(100).delete('-_').first(100) }
      expires_at { SecureRandom.random_number(1.month).seconds.from_now }
    end

    provider 'facebook'
    uid { id }

    info do
      {
        fbook_name: username,
        email: email,
        name: name
      }
    end
  end
end
