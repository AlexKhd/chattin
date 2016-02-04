require 'rake'

begin
  require 'rspec/core/rake_task'
  namespace :spec do
     Rspec::Core::RakeTask.new(:unit) do |t|
       t.pattern = Dir['spec/*/**/*_spec.rb'].reject{ |f| f['/features'] }
     end

    Rspec::Core::RakeTask.new(:integration) do |t|
      t.pattern = "spec/features/**/*_spec.rb"
    end
  end
rescue LoadError
end
