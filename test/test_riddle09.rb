# frozen_string_literal: true

require_relative 'test_helper'

class TestRiddle09 < Test::Unit::TestCase
  def test_find_prev
    service = Riddle09.new('/input_01.txt')
    assert_equal(1097, service.find_prev.sum)
  end

  def test_find_prev_line_sample
    service = Riddle09.new('/input_sample_02.txt')
    assert_equal(-3, service.find_prev_line([0, 3, 6, 9, 12, 15]))
    assert_equal(0, service.find_prev_line([1, 3, 6, 10, 15, 21]))
    assert_equal(5, service.find_prev_line([10, 13, 16, 21, 30, 45]))
  end

  def test_find_next01
    service = Riddle09.new('/input_01.txt')
    assert_equal(2_008_960_228, service.find_next.sum)
  end

  def test_find_steps
    service = Riddle09.new('/input_sample_01.txt')
    assert_equal([3, 3, 3], service.find_steps([0, 3, 6, 9]))
  end

  def test_find_next_sample01
    service = Riddle09.new('/input_sample_01.txt')
    assert_equal([18, 28, 68], service.find_next)
    assert_equal(114, service.find_next.sum)
  end

  def test_input_format
    service = Riddle09.new('/input_sample_01.txt')
    service.input.first.is_a?(Array)
    service.input.first.all?(Integer)
  end
end
