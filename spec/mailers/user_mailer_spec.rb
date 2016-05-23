require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  let(:user)    { FactoryGirl.create(:user) }
  let(:post)    { FactoryGirl.create(:post, user: user) }

  before(:each) do
    ActionMailer::Base.deliveries = []
    UserMailer.news_email(user, post).deliver
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end


  it 'should send an email' do
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  it 'renders the receiver email' do
    expect(ActionMailer::Base.deliveries.first.to).to eq([user.email])
  end

  it 'render the sender email' do
    expect(ActionMailer::Base.deliveries.first.from).to eq(['crawler.robot.2u@gmail.com'])
    end
end
