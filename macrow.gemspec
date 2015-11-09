# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'macrow/version'

Gem::Specification.new do |spec|
  spec.name          = "macrow"
  spec.version       = Macrow::VERSION
  spec.authors       = ["Izumiya Keisuke"]
  spec.email         = ["ksk.i.530@gmail.com"]

  spec.summary       = %q{Small helper for text replacing that using DSL}
  spec.description   = %q{This gem provide DSL for define rules of text replacing. It makes the code more readable and helps avoinding fat model.}
  spec.homepage      = "https://github.com/syguer/macrow"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
