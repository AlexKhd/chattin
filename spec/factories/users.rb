FactoryGirl.define do
  factory :user do |u|
    u.name "Administrator"
    u.sequence(:email) {|n| "person#{n}@example.com" }
    u.password "tester"
    #u.password_confirmation "tester"
  end
end
