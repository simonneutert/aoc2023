# frozen_string_literal: true

require_relative 'test_helper'

class TestRiddle11 < Test::Unit::TestCase
  def test_smart_calculate_distances_sample
    service = Riddle11.new('/input_sample_01.txt')
    service.factor = 10
    assert_equal(1030, service.calculate_distances.values.sum)
  end

  def test_smart_calculate_distances
    service = Riddle11.new('/input_01.txt')
    service.factor = 1_000_000
    assert_equal(519_939_907_614, service.calculate_distances.values.sum)
  end

  def test_find_items_sample
    service = Riddle11.new('/input_sample_01.txt')
    assert_equal(
      [
        [0, 3], [1, 7], [2, 0], [4, 6], [5, 1], [6, 9], [8, 7], [9, 0], [9, 4]
      ],
      service.items
    )
  end

  def test_calculate_distances
    service = Riddle11.new('/input_01.txt')
    assert_equal(100_128, service.calculate_distances.keys.count)
    assert_equal(9_947_476, service.calculate_distances.values.sum)
  end

  def test_calculate_distances_sample
    service = Riddle11.new('/input_sample_01.txt')
    assert_equal(36, service.calculate_distances.keys.count)
    assert_equal(374, service.calculate_distances.values.sum)
  end

  def test_find_items
    service = Riddle11.new('/input_sample_01.txt')
    assert_equal(
      [[0, 3], [1, 7], [2, 0], [4, 6], [5, 1], [6, 9], [8, 7], [9, 0], [9, 4]],
      service.items
    )
  end

  def test_find_empty
    service = Riddle11.new('/input_sample_01.txt')
    assert_equal([3, 7], service.empty_rows)
    assert_equal([2, 5, 8], service.empty_cols)
  end
end
