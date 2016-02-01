require 'rails_helper'

feature 'user login' do

  scenario 'failed with invalid data' do

   visit '/users/sign_in'
   fill_in('user_email', with: 'an_email@dot.com')
   fill_in('user_password', with: 'a_pwd')

   find('input[type = "submit"]').click

   expect(page).to have_content 'Invalid email or password'

  end

  scenario 'success for correct user' do

   visit '/users/sign_in'

  end
end
