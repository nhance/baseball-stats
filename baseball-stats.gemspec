require File.join([File.dirname(__FILE__),'lib','baseball-stats/version.rb'])

Gem::Specification.new do |s|
  s.name        = 'baseball-stats'
  s.version     = BaseballStats::VERSION
  s.license     = 'MIT'
  s.authors     = ['Nicholas Hance']
  s.email       = 'nhance@reenhanced.com'
  s.platform    = Gem::Platform::RUBY
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- spec/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.map { |f| File.basename(f) }
  s.bindir      = 'bin'
  s.summary     = "Baseball statistics tool"

  s.require_paths << 'lib'

  s.add_development_dependency('bundler')

  s.add_dependency('gli')
end
