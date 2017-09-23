# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ui_interactors/version'

Gem::Specification.new do |spec|
  spec.name          = "ui_interactors"
  spec.version       = UiInteractors::VERSION
  spec.authors       = ["Kevin Rood"]
  spec.email         = ["kevin.rood@accelecode.com"]

  spec.summary       = %q{ui_interactors makes it simple to write automated browser tests using selenium-webdriver - tests which are resilient to HTML structure and style changes.}
  spec.description   = %q{ui_interactors makes it simple to write automated browser tests using selenium-webdriver - tests which are resilient to HTML structure and style changes.}
  spec.homepage      = "https://github.com/accelecode/ui_interactors"
  spec.license       = "Apache-2.0"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "selenium-webdriver", "~> 3.5.2"
end
