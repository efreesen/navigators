# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'navigators/version'

Gem::Specification.new do |spec|
  spec.name          = "navigators"
  spec.version       = Navigators::VERSION
  spec.authors       = ["Caio Torres"]
  spec.email         = ["caio.a.torres@gmail.com"]
  spec.summary       = %q{A Base class to help creating navigators to your application business model}
  spec.description   = %q{A Base class to help creating navigators to your application business model}
  spec.homepage      = "https://github.com/efreesen/navigators"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "environments"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "pry-meta"
end
