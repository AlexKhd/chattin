DatabaseCleaner[:active_record].strategy = :truncation

RSpec.configure do |config|
  config.before :suite do |example|
    DatabaseCleaner.clean_with :truncation
  end
  config.before :each do |example|
    DatabaseCleaner.start
  end
  config.after :each do |example|
    DatabaseCleaner.clean
  end
end
