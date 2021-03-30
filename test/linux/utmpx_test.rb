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

  sub_test_case "ut_ prefix access" do

    test "read utmpx_dummy" do
      io = File.open(dump_fixture_path("utmpx_dummy"))
      n = 1
      while !io.eof? do
        entry = @parser.read(io)
        expected = [
          n,
          n * 1000,
          "tty#{n}",
          "id#{n} ",
          "alice#{n}",
          "host#{n}",
        ]
        assert_equal(expected, [entry.ut_type, entry.ut_pid, entry.ut_line, entry.ut_id, entry.ut_user, entry.ut_host])
        n += 1
      end
    end
  end

  sub_test_case "alias access" do

    EXPECTED_TYPES = %i(EMPTY RUN_LVL BOOT_TIME NEW_TIME OLD_TIME INIT_PROCESS LOGIN_PROCESS USER_PROCESS DEAD_PROCESS ACCOUNTING)

    test "alias read" do
      io = File.open(dump_fixture_path("utmpx_dummy"))
      n = 1
      while !io.eof? do
        entry = @parser.read(io)
        expected = [
          EXPECTED_TYPES[n],
          n * 1000,
          "tty#{n}",
          "id#{n} ",
          "alice#{n}",
          "host#{n}",
        ]
        assert_equal(expected, [entry.type, entry.pid, entry.line, entry.id, entry.user, entry.host])
        n += 1
      end
    end

    test "parsed types" do
      io = File.open(dump_fixture_path("utmpx_dummy"))
      n = 1
      while !io.eof? do
        entry = @parser.read(io)
        assert_equal(EXPECTED_TYPES[n], entry.type)
        n += 1
      end
    end

    test "parsed time" do
      io = File.open(dump_fixture_path("utmpx_dummy"))
      n = 1
      while !io.eof? do
        entry = @parser.read(io)
        assert_equal(Time.parse("2021-03-2#{n}T06:49:58,716235+00:00"), entry.time)
        n += 1
      end
    end
  end
end
