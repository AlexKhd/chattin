require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Factory' do
    it 'is not valid without an email' do
      user = User.new
      expect(user).to have_exactly(1).error_on(:email)
      expect(user).not_to be_valid
    end
  end
end
