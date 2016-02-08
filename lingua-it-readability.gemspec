# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lingua/it/readability/version'

Gem::Specification.new do |spec|
  spec.name          = "lingua-it-readability"
  spec.version       = Lingua::It::Readability::VERSION
  spec.authors       = ["Andrea Giacomo Baldan"]
  spec.email         = ["a.g.baldan@gmail.com"]

  spec.summary       = %q{Text readability indexes and stats calibrated on Italian language.}
  spec.description   = %q{Text readability indexes and stats calibrated on Italian language. Inspired by Lingua::EN::Readability and the original perl module Lingua::EN::Fathom. Gulpease and Flesch for italian text is calculated.}
  spec.homepage      = "https://github.com/codepr/lingua-it-readability"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
