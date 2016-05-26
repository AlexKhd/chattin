FactoryGirl.define do
  factory :mail_template do
    description  Faker::Lorem.sentence(1)
    subject      Faker::Lorem.sentence(1)
    body         Faker::Lorem.sentence
  end
end
