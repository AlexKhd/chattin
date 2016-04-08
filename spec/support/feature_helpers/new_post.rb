# create Post
module NewPost
  def new_post(file)
    visit new_post_path

    page.attach_file('post_image', Rails.root + file)
    fill_in 'post_caption', with: caption

    find('input[name="commit"]').trigger('click')
  end
end
