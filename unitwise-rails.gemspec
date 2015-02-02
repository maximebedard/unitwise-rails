$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'unitwise/rails/version'

Gem::Specification.new do |s|
  s.name        = 'unitwise-rails'
  s.version     = Unitwise::Rails::VERSION
  s.authors     = ['Maxime Bedard']
  s.email       = ['maxim3.bedard@gmail.com']
  s.homepage    = 'http://github.com/maximebedard/unitwise-rails'
  s.summary     = 'Provides rails extension to the the refined unitwise gem.'
  s.description = 'Provides rails extension to the the refined unitwise gem.'
  s.license     = 'MIT'

  s.files = Dir['{lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.required_ruby_version = '>= 2.0.0'
  s.add_dependency 'unitwise'
  s.add_dependency 'rails', '~> 4.1.9'

  s.add_development_dependency 'sqlite3'
end
