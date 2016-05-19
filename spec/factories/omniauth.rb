FactoryGirl.define do
  factory :facebook_hash, class: OmniAuth::AuthHash do
		provider 'facebook'
		uid Faker::Number.number(15)
    name = Faker::Name.name
    email = Faker::Internet.email

		info do
			{
        email: email,
				name: name,
			}
		end

		credentials do
			{
        token: SecureRandom.uuid,
        expires_at: Faker::Date.forward(2),
        expires: true
			}
		end

		extra do
			{
				raw_info: {
					email: email,
					id: uid,
          name: name
				}
			}
		end
	end
end
