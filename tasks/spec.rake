# frozen_string_literal: true

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = "spec/**{,/*/**}/*_spec.rb"
  end
rescue LoadError
  warn("Cannot load rspec task.")
end
