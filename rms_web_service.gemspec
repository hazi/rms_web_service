# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rms_web_service/version"

Gem::Specification.new do |spec|
  spec.name          = "rms_web_service"
  spec.version       = RmsWebService::VERSION
  spec.authors       = ["yuhei mukoyama"]
  spec.email         = ["yuhei.mukoyama@gmail.com"]
  spec.summary       = %q{Ruby wrapper for RMS Web Service.}
  spec.description   = %q{Ruby wrapper for RMS Web Service.}
  spec.homepage      = "https://github.com/hazi/rms_web_service"
  spec.license       = "MIT"

  spec.files         = %x[git ls-files -z].split("\x0").reject { |f| f.match(%r{^(test|spec|features|bin)/}) } -
                       %w[.rubocop.yml .travis.yml]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.rdoc_options = ["--main", "README.md"]

  spec.add_dependency "faraday"
  spec.add_dependency "nokogiri"
  spec.add_dependency "nori"
  spec.add_dependency "activesupport"
  spec.add_dependency "builder"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "yard"
end
