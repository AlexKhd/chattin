require 'rails_helper'

feature 'Main page' do

  scenario 'structure check' do

   visit '/'
   expect(page).to have_selector('h1', text: 'Yet another portal')
   expect(page).to have_link 'Chat'

  end
end
