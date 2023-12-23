# frozen_string_literal: true

require_relative 'test_helper'

class TestRiddle01 < Test::Unit::TestCase
  def test_result_sample01
    assert_equal(142, Riddle01.new('/input_sample_01.txt').call)
  end

  def test_riddle01
    assert_equal(54_605, Riddle01.new('/input_01.txt').call)
  end

  def test_result_sample02
    assert_equal(281, Riddle01.new('/input_sample_02.txt').call(detect_words: true))
  end

  def test_riddle02
    assert_equal(55_429, Riddle01.new('/input_02.txt').call(detect_words: true))
  end
end
