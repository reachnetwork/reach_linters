require 'guard-brakeman'
require 'guard-bundler-audit'
require 'rubocop'

module ReachLinters
  # Your code goes here...
end

require "reach_linters/railtie" if defined?(Rails)