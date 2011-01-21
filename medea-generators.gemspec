# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "medea-generators"
  s.version     = "0.2.7"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michael Jensen"]
  s.email       = ["michaelj@jasondb.com"]
  s.homepage    = ""
  s.summary     = %q{Medea Generators provides scaffolding for Rails projects using Medea to access JasonDB}
  s.description = %q{Medea Generators provides scaffolding for Rails projects using Medea to access JasonDB.
This is very closely modelled on Ryan Bates' Nifty Generators.}

  s.add_development_dependency 'rails', '~> 3.0.3'
  s.add_dependency 'medea'
  s.add_dependency 'rest-client'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
