ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/poltergeist'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app, debug: false, js_errors: false, timeout: 120, inspector: true
  )
end

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.include Capybara::DSL
  config.include WaitForAjaxHelpers

  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.after(:each) do |example|
    if example.exception && example.metadata[:type]
      tmp = 'spec/support/screenshots/'
      screenshot_path = Rails.root.join(
        "#{tmp + example.location.split('/').last}_#{Time.now.to_i}.png"
      )
      page.save_screenshot(screenshot_path)
    end
  end
end

def save_timestamped_screenshot(page, meta)
  filename = File.basename(meta[:file_path])
  line_number = meta[:line_number]

  t = Time.now
  time = t.strftime('%Y-%m-%d-%H-%M-%S.')
  timestamp = "#{time}#{format('%03d', (t.usec / 1000)).to_i}"

  screenshot_name = "screenshot-#{filename}-#{line_number}-#{timestamp}.png"
  screenshot_path = "spec/screenshots/#{screenshot_name}"

  page.save_screenshot(screenshot_path)

  puts "\n  Screenshot: #{screenshot_path}"
end
