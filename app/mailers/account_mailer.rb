class AccountMailer < ApplicationMailer
  default from: 'crawler.robot.2u@gmail.com'

  def notify(message, account)
    @message = message
    @user = account
    mail(to: "#{account.email}",
         subject: @message.subject,
         body: @message.body
         )
  end
end
