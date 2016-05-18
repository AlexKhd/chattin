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
    subject { User.find_for_oauth facebook_auth }

    let(:facebook_auth) { create :facebook_auth }

    xit 'returns the user' do
			expect(User.find_for_oauth(auth_hash).username).to eq(user.username)
  	end

    context 'when user is not exists' do
      xit 'creates new user' do
        expect { subject }.to change(User, :count).by 1
      end

      xit "properly sets user's email" do
        user = subject
        expect(user.email).to eq github_auth.info.email
      end

      xit "properly sets user's name" do
        user = subject
        expect(user.name).to eq github_auth.info.name
      end

      xit "properly sets user's github_name" do
        user = subject
        expect(user.github_name).to eq github_auth.info.nickname
      end
    end

    context 'when user already exists' do
      let!(:user) { create :user, provider: 'facebook', uid: facebook_auth.uid }

      xit 'does not create new user' do
        expect { subject }.not_to change(User, :count)
      end
    end
  end
end
