FactoryGirl.define do
  factory :facebook, class: 'Identity' do
    uid '123321123321'
    provider 'facebook'
    user_id nil
  end
end
