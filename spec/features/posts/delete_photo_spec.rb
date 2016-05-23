require 'rails_helper'
require 'support/feature_helpers/new_post'

include NewPost

feature 'Posts' do
  let(:caption)     { Faker::Lorem.sentence }
  let(:user)        { FactoryGirl.create(:user, :confirmed) }

  before do
    login_as(user, scope: :user)
    new_post('spec/fixtures/aphoto.jpeg')
    visit posts_path
    expect(page).to have_link I18n.t(:delete_post)
  end

  scenario 'user cannot delete post until logged in' do
    logout
    visit posts_path
    expect(page).to have_link I18n.t(:new_post)
    expect(page).not_to have_link I18n.t(:delete_post)
  end

  scenario 'user deleting photo' do
    click_link I18n.t(:delete_post)
    expect(current_path).to eq posts_path
    expect(page).not_to have_content(caption)
  end
end
