begin
  require "bundler/gem_tasks"
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require 'rdoc/task'
RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Locations'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'engine_cart/rake_task'

load 'rails/tasks/statistics.rake'

task ci: ['engine_cart:generate'] do
  Rake::Task['spec'].invoke
end

task clean: 'engine_cart:clean'
task default: [:ci]
