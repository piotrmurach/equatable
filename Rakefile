# encoding: utf-8

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

FileList['tasks/**/*.rake'].each { |task| import task }

task :default => [:spec]

desc 'Run all specs'
task :ci => %w[ spec ]
