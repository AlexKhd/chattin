require 'rails_helper'

feature 'user signup' do

  let(:email)      { Faker::Internet.email }
  let(:name)       { Faker::Name.name }
  let(:password)   { Faker::Internet.password }

  scenario 'failed with short password' do
    visit '/users/sign_up'

    error_message = 'This field is required'
    expect(find('#new_user')).to have_selector('.login-help', text: error_message, count: 4)

    fill_in 'user_name', with: name
    expect(find('#new_user')).to have_selector('.login-help', text: error_message, count: 3)
    fill_in 'user_email', with: email
    expect(find('#new_user')).to have_selector('.login-help', text: error_message, count: 2)
    fill_in 'user_password', with: 'a_pwd'
    expect(find('#new_user')).to have_selector('.login-help', text: error_message, count: 1)
    fill_in 'user_password_confirmation', with: 'a_pwd'

    error_message = 'Password has to be at least 6 characters'
    expect(find('#new_user')).to have_selector('.login-help', text: error_message, count: 2)

    find('input[type="submit"]').click

    visit '/'
    expect(page).to have_link 'Login'
  end

  scenario 'failed when username exists' do
    user = FactoryGirl.create(:user, :confirmed)
    user.confirmed_at = Time.now
    user.save
    visit '/users/sign_up'

    fill_in 'user_name', with: user.name
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password

    find('input[type="submit"]').click

    visit '/'
    expect(page).to have_link 'Login'
  end

  scenario 'success for correct user' do
    visit '/users/sign_in'
    user = FactoryGirl.create(:user, :confirmed)
    user.confirmed_at = Time.now
    user.save
    # login_as(user, scope: :user)
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    find('input[type="submit"]').click

    visit '/'
    expect(page).to have_link 'Logout'
  end
end
