require 'rails_helper'

feature 'editing template' do
  let(:admin)           { create(:user, :is_admin) }
  let!(:mail_template)  { create(:mail_template) }
  let(:description)    { Faker::Lorem.sentence(2) }

  scenario 'successfully' do
    login_as(admin, scope: :user)
    visit admin_postmans_path

    expect(page).to have_selector('.table tbody', text: mail_template.description)
    click_link 'Edit'

    fill_in 'Description', with: description
    click_button 'Save template'
    expect(current_path).to eq admin_postmans_path
    expect(page).to have_selector('.table tbody', text: description)
  end
end
