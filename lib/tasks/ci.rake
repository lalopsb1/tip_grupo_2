unless Rails.env.production?
  require 'rspec/core/rake_task'
  require 'cucumber/rake/task'

  namespace :ci do
    desc 'Run all tests'
    task tests: [:spec, :cucumber]
  end
end