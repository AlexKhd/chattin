class DashboardController < ApplicationController
  require 'mixpanel-ruby'
  after_action :identify_mixpanel_id, :only => [:index]

  def index
  end

  protected

  def identify_mixpanel_id
    if Rails.env.production?
      tracker = Mixpanel::Tracker.new(Rails.application.secrets.mixpanel_key)
      tracker.track('ID', 'Script run')
    elsif Rails.env.test?
      tracker = Mixpanel::Tracker.new(ENV['MIXPANEL_KEY'])
      tracker.track('ID', 'Script run')
    end
  end
end
