# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capybara/js/version'

Gem::Specification.new do |spec|
  spec.name          = "capybara-js"
  spec.version       = Capybara::Js::VERSION
  spec.authors       = ["Joe Nelson"]
  spec.email         = ["cred+github@begriffs.com"]
  spec.description   = %q{Helpers to wait for, spy on, and stub JavaScript}
  spec.summary       = %q{Fix mysterious timing issues by waiting for JavaScript}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
