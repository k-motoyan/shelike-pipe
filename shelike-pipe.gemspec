# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shelike/pipe/version'

Gem::Specification.new do |spec|
  spec.name = 'shelike-pipe'
  spec.version = Shelike::Pipe::VERSION
  spec.authors = ['k-motoyan']
  spec.email = ['k.motoyan888@gmail.com']

  spec.summary = 'shell like pipe operator for ruby.'
  spec.homepage = 'https://github.com/k-motoyan/shelike-pipe'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
