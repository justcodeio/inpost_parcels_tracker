# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inpost_parcels_tracker/version'

Gem::Specification.new do |spec|
  spec.name          = "inpost_parcels_tracker"
  spec.version       = InpostParcelsTracker::VERSION
  spec.authors       = ["Michal Andros"]
  spec.email         = ["michalandros@gmail.com"]

  spec.summary       = %q{Track changes to Your parcels when using Inpost services}
  spec.description   = %q{Check your parcel status and history by providing a inpost parcel tracking number}
  spec.homepage      = "https://github.com/justcodeio/inpost_parcels_tracker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
