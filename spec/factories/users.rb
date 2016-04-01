FactoryGirl.define do
  factory :user do |u|
    u.name "John Doe"
    u.sequence(:email) {|n| "person#{n}@example.com" }
    u.password "tester"
    u.password_confirmation "tester"
    role "user"
  end

  factory :admin, class: User do
    name "Admin"
    sequence(:email) {|n| "person#{n}@example.com" }
    role "admin"
  end

  factory :family, class: User do
    name "Family user"
    sequence(:email) {|n| "person#{n}@example.com" }
    role "family"
  end

  trait :confirmed do
    confirmed_at 1.hour.ago
  end

  trait :not_confirmed do
    confirmed_at nil

    after(:create) do |user|
      post = create(:post, user: user)
      user.update_attributes(confirmation_sent_at: 3.days.ago)
    end
  end
end
