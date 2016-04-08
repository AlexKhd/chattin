module UsersHelper
  def avatar_url(user)
    user.avatar_file_name.blank? ? nil : user.avatar_file_name
  end
end
