$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "reach_linters/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "reach_linters"
  s.version     = ReachLinter::VERSION
  s.authors     = ["Gustav E Gennrich"]
  s.email       = ["devs@sreducationgroup.org"]
  s.homepage    = "https://www.sreducationgroup.org"
  s.summary     = "Set of gems to analyze code for best practices, security issues, errors, etc. Will copy any configuration files into the root path of your project."
  s.description = "Set of gems to analyze code for best practices, security issues, errors, etc. Will copy any configuration files into the root path of your project."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency "guard-brakeman"
  s.add_development_dependency "guard-bundler-audit"
  s.add_development_dependency "guard-rubocop"
  s.add_development_dependency "guard-jshintrb"
end
