require 'rails_helper'
require 'support/feature_helpers/new_post'

include NewPost

feature 'posts'do

  let(:caption)     { Faker::Lorem.sentence }
  let(:user)        { FactoryGirl.create(:user)}

  scenario 'adding new photo' do
    login_as(user, scope: :user)
    new_post('spec/fixtures/aphoto.jpeg')

    expect(page).to have_selector(".post", text: caption)
  end

end
