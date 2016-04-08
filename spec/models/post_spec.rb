require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Factory' do
    it 'is not valid without an image' do
      post = Post.new
      expect(post).to have_exactly(1).error_on(:image)
      expect(post).not_to be_valid
    end
  end
end
