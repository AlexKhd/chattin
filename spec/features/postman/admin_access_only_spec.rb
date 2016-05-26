require 'rails_helper'

feature 'mail templates funtionality' do
  let(:user)        { create(:user, :confirmed) }
  let(:admin)       { create(:user, :is_admin) }

  scenario 'access denied for anonymous user' do
    visit '/'
    expect(page).to have_link 'Login'
    expect(page).not_to have_link 'Admin'

    visit admin_postmans_path
    expect(current_path).to eq root_path
  end

  scenario 'access to user denied' do
    login_as(user, scope: :user)

    visit '/'
    expect(page).to have_link 'Logout'
    expect(page).not_to have_link 'Admin'

    visit admin_postmans_path
    expect(current_path).to eq root_path
  end

  scenario 'access to admin allowed' do
    login_as(admin, scope: :user)

    visit '/'
    expect(page).to have_link 'Logout'
    expect(page).to have_link 'Admin'

    visit admin_postmans_path
    expect(current_path).to eq admin_postmans_path
    expect(page).to have_button 'New Template'
  end
end
