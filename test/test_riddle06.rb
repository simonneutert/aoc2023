# frozen_string_literal: true

require_relative 'test_helper'

class TestRiddle06 < Test::Unit::TestCase
  def test_prepare_data_sample
    service = Riddle06.new('/input_sample_01.txt')
    service.data
    assert_equal(
      [[7, 9], [15, 40], [30, 200]],
      service.data
    )
  end

  def test_calculate_possible_ways_to_win_sample7to9
    service = Riddle06.new('/input_sample_01.txt')
    possible_ways_to_win = service.calculate_possible_ways_to_win([7, 9])
    assert_equal(4, possible_ways_to_win)
  end

  def test_calculate_possible_ways_to_win_sample_solution
    service = Riddle06.new('/input_sample_01.txt')
    result = service.product_of_possible_ways_to_win
    assert_equal(288, result)
  end

  def test_calculate_possible_ways_to_win02
    service = Riddle06.new('/input_02.txt')
    possible_ways_to_win = service.calculate_possible_ways_to_win(service.joined_data)

    assert_equal(37_286_485, possible_ways_to_win)
  end

  def test_calculate_race_sample_bsearch_result_sample02
    service = Riddle06.new('/input_sample_02.txt')
    possible_ways_to_win = service.calculate_possible_ways_to_win(service.joined_data)

    assert_equal(71_503, possible_ways_to_win)
  end

  def test_calculate_possible_ways_to_win01
    service = Riddle06.new('/input_01.txt')
    result = service.product_of_possible_ways_to_win

    assert_equal(275_724, result)
  end

  def test_calculate_race_sample02
    service = Riddle06.new('/input_sample_02.txt')
    result = service.product_of_possible_ways_to_win

    assert_equal(71_503, result)
  end

  def test_prepare_data01
    service = Riddle06.new('/input_01.txt')
    service.data
    assert_equal(
      [[59, 543], [68, 1020], [82, 1664], [74, 1022]],
      service.data
    )
  end
end
