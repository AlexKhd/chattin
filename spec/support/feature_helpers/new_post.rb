module NewPost
  def new_post(file)
    visit posts_path
    expect(page).to have_link('New Post')
    # MouseEventFailed
    #click_link 'New Post'
    find('a', text: 'New Post').trigger('click')
    #find('New Post').click

    page.attach_file('post_image', Rails.root + file)
    fill_in 'post_caption', with: caption

    find('input[name="commit"]').trigger('click')
  end
end
