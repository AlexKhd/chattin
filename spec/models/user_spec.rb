require 'rails_helper'

describe User do
  let(:user)      { create(:user) }
  let(:admin)     { create(:user, :is_admin) }

  it 'user? should return true for new user' do
    expect(user.user?).to be true
  end

  it 'admin? should return true if user is admin' do
    expect(admin.admin?).to be true
  end

  describe '.from_omniauth' do
    subject { User.find_for_oauth facebook_hash }

    let(:facebook_hash) { create :facebook_hash }

    context 'when user is not exists' do
      it 'creates new user' do
        expect { subject }.to change(User, :count).by 1
      end

      it "properly sets user's email" do
        user = subject
        expect(user.email).to eq facebook_hash.info.email
      end

      it "properly sets user's name" do
        user = subject
        expect(user.name).to eq facebook_hash.info.name
      end

      it "properly sets user's facebook_name" do
        user = subject
        expect(user.facebook_name).to eq facebook_hash.info.name
      end
    end

    context 'when user already exists' do
      it "doesn't allow duplicate users" do
		  	user = User.find_for_oauth(facebook_hash)
		  	expect { User.find_for_oauth(facebook_hash) }.to_not change(User, :count)
		  	expect(User.find_for_oauth(facebook_hash)).to eql(user)
		  end
    end
  end
end
