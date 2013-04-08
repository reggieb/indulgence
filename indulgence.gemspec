$:.push File.expand_path("../lib", __FILE__)

require "indulgence/version"

Gem::Specification.new do |s|
  s.name        = "indulgence"
  s.version     = Indulgence::VERSION
  s.authors     = ["Rob Nichols"]
  s.email       = ["rob@undervale.co.uk"]
  s.homepage    = "https://github.com/reggieb/indulgence"
  s.summary     = "Yet another permissions gem"
  s.description = "Packages permission functionality into a set of permission objects."

  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  
  s.add_dependency 'activerecord'
  s.add_development_dependency 'sqlite3'
#  s.add_development_dependency 'standalone_migrations'
end
