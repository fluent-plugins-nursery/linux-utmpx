# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "linux/utmpx"

require "time"
require "test-unit"

def dump_fixture_path(name)
  File.join(File.dirname(__FILE__),
            "fixtures",
            "#{name}.dump")
end
