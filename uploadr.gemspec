# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uploadr/version'

Gem::Specification.new do |spec|
  spec.name          = "uploadr"
  spec.version       = Uploadr::VERSION
  spec.authors       = ["Dan Ryan"]
  spec.email         = ["scriptfu@gmail.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.files         = %w[ LICENSE.txt CONTRIBUTING.md CHANGELOG.md README.md Rakefile reveille.gemspec ]
  %w[ lib bin spec ].each do |dir|
    spec.files += Dir["#{dir}/**/*"]
  end

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version     = '>= 1.9.2'
  spec.required_rubygems_version = '>= 1.3.6'

  spec.add_dependency 'clamp', '~> 0.6'
  spec.add_dependency 'flickraw'
  spec.add_dependency 'celluloid'
  spec.add_dependency 'parseconfig'
  spec.add_dependency 'progress_bar'
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency 'guard-rspec', '>= 3.0.2'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '>= 2.13.0'
  spec.add_development_dependency 'webmock', '>= 1.13.0'
  spec.add_development_dependency "rake"
end
