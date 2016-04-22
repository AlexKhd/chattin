require 'rails_helper'

feature 'profile' do
  let(:user)        { FactoryGirl.create(:user, :confirmed) }

  scenario 'can view my profile' do
    login_as(user, scope: :user)
    visit '/'


    expect(page).to have_selector('.post', text: caption)
  end
end
