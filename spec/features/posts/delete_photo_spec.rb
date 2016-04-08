require 'rails_helper'
require 'support/feature_helpers/new_post'

include NewPost

feature 'posts' do
  let(:caption)     { Faker::Lorem.sentence }
  let(:user)        { FactoryGirl.create(:user, :confirmed) }

  scenario 'cannot delete photo until logged in' do
    visit posts_path
    login_as(user, scope: :user)

    new_post('spec/fixtures/aphoto.jpeg')

    expect(page).to have_link('New Post')
  end

  scenario 'deleting photo' do
    login_as(user, scope: :user)

    visit posts_path
    expect(page).to have_link('Logout')

    new_post('spec/fixtures/aphoto.jpeg')

    expect(page).to have_link('Delete Post')

    click_link('Delete Post')
    expect(page).not_to have_content(caption)
  end

  scenario 'cannot delete until logged in' do
    visit posts_path
    expect(page).not_to have_link('Delete Post')
  end
end
