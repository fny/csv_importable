# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv_importable/version'

Gem::Specification.new do |spec|
  spec.name          = 'csv_importable'
  spec.version       = CsvImportable::VERSION
  spec.authors       = ["Faraz Yashar"]
  spec.email         = ['faraz.yashar@gmail.com']
  spec.summary       = %q[Simple CSV imports for ActiveRecord]
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_runtime_dependency 'activerecord', '>= 3.2.17'
end
