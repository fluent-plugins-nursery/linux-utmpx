# frozen_string_literal: true

require "test_helper"

class Linux::UtmpxTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::Linux::Utmpx.const_defined?(:VERSION)
    end
  end
end

class Linux::UtmpxParserTest < Test::Unit::TestCase

  setup do
    @parser = Linux::Utmpx::UtmpxParser.new
  end

  test "types of ut_type" do
    io = File.open(dump_fixture_path("utmpx_type"))
    types = []
    while !io.eof? do
      types << @parser.read(io)[:ut_type].dup
    end
    expected = 9.times.each.collect do |i| i + 1 end
    assert_equal(expected, types)
  end

  test "alice login" do
    io = File.open(dump_fixture_path("alice_login"))
    entry = @parser.read(io)
    expected = {
      ut_type: 7,
      ut_pid: 121110,
      ut_line: "tty7",
      ut_id: ":0  ",
      ut_user: "alice",
      ut_host: ":0",
      time: Time.parse("2021-03-23 15:49:58.716235 +0900")
    }
    assert_equal(expected, {
                   ut_type: entry[:ut_type],
                   ut_pid: entry[:ut_pid],
                   ut_line: entry[:ut_line],
                   ut_id: entry[:ut_id],
                   ut_user: entry[:ut_user],
                   ut_host: entry[:ut_host],
                   time: entry.time
                 })
  end
end
