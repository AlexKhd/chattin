FactoryGirl.define do
  factory :user do
    identities [
    	FactoryGirl.build(:facebook)
    ]
    name 'John Doe'
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'tester'
    password_confirmation 'tester'
    confirmed_at Date.today
  end

  trait :is_admin do
    name 'Admin'
    role 'admin'
  end

  trait :is_family do
    name 'Family user'
    role 'family'
  end

  trait :confirmed do
    confirmed_at 1.hour.ago
  end

  trait :not_confirmed do
    confirmed_at nil

    after(:create) do |user|
      # post = create(:post, user: user)
      user.update_attributes(confirmation_sent_at: 3.days.ago)
    end
  end
end
