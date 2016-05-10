class UserMailer < ApplicationMailer
  default from: 'crawler.robot.2u@gmail.com'

  def news_email(user)
    @user = user
    @url  = 'http://chattin.gq/'
    mail(to: "#{@user.name} <#{@user.email}>", subject: 'Новые фотографии',
         template_path: 'user_mailer', template_name: 'news_email')
  end
end
