require 'rails_helper'

feature 'Reset password' do
  let(:user) { FactoryGirl.create(:user) }

    scenario "User resets password using his email" do
      visit new_user_password_path

      within '#new_user' do
        fill_in 'user_login', with: user.email
        click_on 'Send me reset password instructions'
      end

      expect(current_path).to eq new_user_session_path
    end
  end
