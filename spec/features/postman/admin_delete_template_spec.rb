require 'rails_helper'

feature 'deleting template' do
  let(:admin)           { create(:user, :is_admin) }
  let!(:mail_template)   { create(:mail_template) }

  scenario 'successfully' do
    login_as(admin, scope: :user)
    visit admin_postmans_path

    expect(page).to have_selector('.table tbody', text: mail_template.description)
    click_link 'Destroy'
    expect(page).not_to have_content mail_template.description
  end
end
