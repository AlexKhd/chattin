module OmniauthTestHelper
  def valid_facebook_login_setup
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        provider: 'facebook',
        uid: '9876543221',
        info: {
          email: 'test@example.com',
          name: 'Facebook Name'
        },
        credentials: {
          token: '1234561234',
          expires_at: Time.now + 1.week,
          expires: true
        },
        extra: {
          raw_info: {
            email: 'test@example.com',
  					id: '1234561234',
            name: 'Facebook Name'
          }
        }
      })
  end
end
