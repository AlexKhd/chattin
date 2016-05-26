require 'rails_helper'

feature 'creating post template' do
  let(:admin)        { create(:user, :is_admin) }
  let(:description)  { Faker::Lorem.sentence(1) }

  before do
    login_as(admin, scope: :user)
    visit admin_postmans_path
    click_button 'New Template'
  end

  scenario 'can\'t save with empty fields' do
    click_button 'Save template'
    expect(page).to have_selector('.mail_template_description', text: 'can\'t be blank')
  end

  scenario 'will save with correct fields' do
    fill_in 'Description', with: description
    fill_in 'Subject', with: Faker::Lorem.sentence(1)
    fill_in 'Body', with: Faker::Lorem.sentence

    click_button 'Save template'
    expect(current_path).to eq admin_postmans_path
    expect(page).to have_selector('.table tbody', text: description)
  end
end
