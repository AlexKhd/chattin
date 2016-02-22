require 'rails_helper'

feature 'counter' do

  scenario 'starts with zero on new photo' do
    visit posts_path

    #lastpost = Posts.last
    #expect(page).to have_selector("#counter_#{lastpost.id}", text: '0')

  end

end
