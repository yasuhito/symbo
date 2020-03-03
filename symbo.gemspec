# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'symbo/version'

Gem::Specification.new do |spec|
  spec.name          = 'symbo'
  spec.version       = Symbo::VERSION
  spec.authors       = ['Yasuhito Takamiya']
  spec.email         = ['yasuhito@gmail.com']

  spec.summary       = 'A simple CAS (computer algebra system) in Ruby'
  spec.homepage      = 'https://github.com/yasuhito/symbo'
  spec.license       = 'MIT'

  spec.required_ruby_version = '~> 2.7'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/yasuhito/symbo'
  spec.metadata['changelog_uri'] = 'https://github.com/yasuhito/symbo/blob/develop/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
