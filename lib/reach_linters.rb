module ReachLinters
  # Your code goes here...
end

require 'guard-brakeman'
require 'guard-bundler-audit'

require "reach_linters/railtie" if defined?(Rails)