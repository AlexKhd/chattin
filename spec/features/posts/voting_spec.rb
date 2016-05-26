require 'rails_helper'

feature 'user vote' do
  let(:caption)     { Faker::Lorem.sentence(3) }
  let(:user)        { FactoryGirl.create(:user, :confirmed) }
  let(:post)        { FactoryGirl.create(:post, user: user) }

  scenario 'cannot vote until logged in - redirect to login page' do
    post
    visit posts_path

    find('input.opacity4', match: :first).trigger('click')
    wait_for_ajax
    expect(page).to have_field('user[login]')
  end

  scenario 'check positive vote & not allowed to vote twice' do
    login_as user, scope: :user
    post
    visit posts_path
    expect(page).to have_css('.counter p', text: '0')

    find("input[value='+']").click
    wait_for_ajax
    expect(page).to have_css('.counter p', text: '1')

    find("input[value='+']").click
    wait_for_ajax
    expect(page).not_to have_css('.counter p', text: '2')
  end

  scenario 'check negative vote & not allowed to vote twice' do
    login_as user, scope: :user
    post
    visit posts_path
    expect(page).to have_css('.counter p', text: '0')

    find("input[value='-']").click
    wait_for_ajax
    expect(page).to have_css('.counter p', text: '-1')

    find("input[value='-']").click
    wait_for_ajax
    expect(page).not_to have_css('.counter p', text: '-2')
  end
end
