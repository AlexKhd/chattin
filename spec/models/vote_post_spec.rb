require 'rails_helper'

describe VotePost do

  describe 'associations' do
    it { is_expected.to belong_to :post }
    it { is_expected.to belong_to :user }
  end
end
