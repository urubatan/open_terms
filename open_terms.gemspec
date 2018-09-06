# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "open_terms/version"

Gem::Specification.new do |s|
  s.name        = "open_terms"
  s.version     = OpenTerms::VERSION
  s.authors     = ["Rodrigo Urubatan"]
  s.email       = ["rodrigo@urubatan.com.br"]
  s.homepage    = "http://www.urubatan.com.br"
  s.summary     = %q{Easy way to open many terminal windows for OSX and Linux}
  s.description = %q{Easy way to open many terminals for OSX and Linux}

  s.rubyforge_project = "open_terms"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", ">= 2.0.0"
  s.add_development_dependency "rspec-mocks", ">= 2.0.0"
  # s.add_runtime_dependency "rest-client"
end
