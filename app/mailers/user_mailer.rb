class UserMailer < ApplicationMailer
  default from: Rails.application.secrets.gmail_user_name_mailer

  def news_email(user)
    @user = user
    @url  = 'http://chattin.gq/'
    mail(from: 'Admin', to: "#{@user.name} <#{@user.email}>", subject: 'Новые фотографии',
         template_path: 'user_mailer', template_name: 'news_email')
  end
end
