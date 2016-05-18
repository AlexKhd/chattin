require 'rails_helper'

describe "GET '/users/auth/facebook/callback'" do

  before(:each) do
    valid_facebook_login_setup
    get "/users/auth/facebook/callback"
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  xit "should set user_id" do
    expect(session[:user_id]).to eq(User.last.id)
  end

  xit "should redirect to root" do
    expect(response).to redirect_to root_path
  end
end

describe "GET '/auth/failure'" do

  xit "should redirect to root" do
    get "/auth/failure"
    expect(response).to redirect_to root_path
  end
end
