class DashboardController < ApplicationController
  require 'mixpanel-ruby'
  after_action :identify_mixpanel_id, :only => [:index]

  def index
  end

  protected

  def identify_mixpanel_id
      tracker = Mixpanel::Tracker.new(Rails.application.secrets.mixpanel_key)
      tracker.track('ID', 'Script run')
  end
end
