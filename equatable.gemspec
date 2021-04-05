# frozen_string_literal: true

require_relative "lib/equatable/version"

Gem::Specification.new do |spec|
  spec.name          = "equatable"
  spec.version       = Equatable::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["piotr@piotrmurach.com"]
  spec.summary       = %q{Provide equality comparison methods for objects based on their attributes.}
  spec.description   = %q{Provide equality comparison methods for objects based on their attributes by generating implementations for the ==, eql?, hash and inspect methods.}
  spec.homepage      = "https://github.com/piotrmurach/equatable"
  spec.license       = "MIT"
  if spec.respond_to?(:metadata=)
    spec.metadata = {
      "allowed_push_host" => "https://rubygems.org",
      "bug_tracker_uri"   => "#{spec.homepage}/issues",
      "changelog_uri"     => "#{spec.homepage}/blob/master/CHANGELOG.md",
      "documentation_uri" => "https://www.rubydoc.info/github/piotrmurach/equatable",
      "homepage_uri"      => spec.homepage,
      "source_code_uri"   => spec.homepage
    }
  end
  spec.files         = Dir["lib/**/*"]
  spec.extra_rdoc_files = ["README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = Gem::Requirement.new(">= 2.0.0")

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0"
end
