module UsersHelper

  def avatar_url(user)
    if user.avatar_file_name.blank?
      return nil
    else
      return user.avatar_file_name
    end
  end
end
