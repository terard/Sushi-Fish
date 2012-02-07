# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sushifish/version"

Gem::Specification.new do |s|
  s.name        = "sushifish"
  s.version     = Sushifish::VERSION
  s.authors     = ["Travis"]
  s.email       = ["travis@impossiblecreature.com"]
  s.homepage    = ""
  s.summary     = %q{The firt public version of the infamous Sushi Gem.}
  s.description = %q{Sushi Fish is a generator that gives a raw rails app ready for content. It is a great starting point to a CMS driven site.}

  s.rubyforge_project = "sushifish"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
