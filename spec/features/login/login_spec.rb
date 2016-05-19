require 'rails_helper'

feature 'user login' do

  let(:email)  { Faker::Internet.email }

  scenario 'failed with short password' do
    visit '/users/sign_in'

    error_message = 'This field is required'
    expect(find('#new_user')).to have_selector('.login-help', text: error_message, count: 2)

    fill_in 'user_login', with: email
    expect(find('#new_user')).to have_selector('.login-help', text: error_message)
    fill_in 'user_password', with: 'a_pwd'

    expect(find('#new_user')).not_to have_selector('.login-help', text: error_message)

    error_message = 'Password has to be at least 6 characters'
    expect(page).to have_selector '#new_user .login-help', text: error_message

    find('input[type="submit"]').click

    visit '/'
    expect(page).not_to have_link 'Logout'
  end

  scenario 'failed with invalid data' do
    visit '/users/sign_in'

    fill_in 'user_login', with: email
    fill_in 'user_password', with: 'invalid_password'

    find('input[type="submit"]').click

    error_message = 'Invalid login or password'
    expect(page).to have_selector '.alert', text: error_message
  end

  scenario 'success for correct user' do
    visit '/users/sign_in'
    user = FactoryGirl.create(:user, :confirmed)
    user.confirmed_at = Time.now
    user.save
    # login_as(user, scope: :user)
    fill_in 'user_login', with: user.email
    fill_in 'user_password', with: user.password
    find('input[type="submit"]').click

    visit '/'
    expect(page).to have_link 'Logout'
  end

  scenario "with valid omniauth Facebook" do
    valid_facebook_login_setup
    visit '/users/sign_in'

    click_link 'btn_via_facebook'

    expect(page).to have_link("Logout")
  end
end
