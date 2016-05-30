require 'rails_helper'

feature 'profile' do
  let(:user)        { FactoryGirl.create(:user, :confirmed) }

  scenario 'can view my profile' do
    login_as(user, scope: :user)
    visit '/'
    find('#avatar').click

    expect(page).to have_selector('h4', text: 'Your profile'.upcase)
  end
end
