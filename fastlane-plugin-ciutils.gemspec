# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/ciutils/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-ciutils'
  spec.version       = Fastlane::Ciutils::VERSION
  spec.author        = %q{Nicolae Ghimbovschi}
  spec.email         = %q{xfreebird@gmail.com}

  spec.summary       = %q{Various utilities for CI and command line}
  spec.homepage      = "https://github.com/xfreebird/fastlane-plugin-ciutils"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'fastlane-plugin-update_project_codesigning'
  spec.add_dependency 'fastlane-plugin-jira_transition'
  spec.add_dependency 'slather'
  spec.add_dependency 'ocunit2junit'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 1.110.0'
end
