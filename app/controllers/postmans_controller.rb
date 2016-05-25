class PostmansController < ApplicationController

  before_action :set_template, only: [:destroy, :show, :edit, :update, :sender]
  before_action :authenticate_user!

  def index
    @mailtemplates = MailTemplate.all
  end

  def show
  end

  def edit
  end

  def update
    if @mailtemplate.update(template_params)
			redirect_to postmans_path, notice: 'Template updated!'
		else
			render 'edit'
		end
  end

  def sender
    if current_user && current_user.admin?
      user = User.find_by_id(@mailtemplate.recipient)
      AccountMailer.notify(@mailtemplate, user).deliver_now
      redirect_to :back, notice: 'Email sent'
    else
      redirect_to :back, notice: 'You\'re not an admin!'
    end
  end

  def new
    @mailtemplate = MailTemplate.new
  end

  def create
    @mailtemplate = MailTemplate.new(template_params)
    if @mailtemplate.save
      redirect_to postmans_path, notice: 'Template saved!'
    else
      render 'new'
    end
  end

  def destroy
    @mailtemplate.destroy
		redirect_to postmans_path, notice: 'Template deleted!'
  end

  private

  def set_template
    @mailtemplate = MailTemplate.find(params[:id])
  end

  def template_params
    params.require(:mail_template).permit(:body, :description, :subject,
      :locale, :handler, :format, :recipient)
  end
end
