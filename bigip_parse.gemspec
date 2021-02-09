# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bigip_parse/version'

Gem::Specification.new do |spec|
  spec.name          = 'bigip_parse'
  spec.version       = BigIParse::VERSION
  spec.authors       = ['Jonathan Stacks']
  spec.email         = ['jonstacks13@gmail.com']

  spec.summary       = 'Simple library to parse BIG IP configurations'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/jonstacks13/bigip_parse'

  spec.required_ruby_version = '>= 2.6.0'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '~> 4.2'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'rubocop', '~> 0.55'
end
