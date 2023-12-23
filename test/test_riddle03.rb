# frozen_string_literal: true

require_relative 'test_helper'

class TestRiddle03 < Test::Unit::TestCase
  def test_sample01
    res = Riddle03.new('/input_sample_01.txt').call
    assert_equal([35, 467, 592, 598, 617, 633, 664, 755].sort, res[:parts])
    assert_equal(4361, res[:parts].sum)
  end

  def test_input01
    res = Riddle03.new('/input_01.txt').call
    assert_equal(553_825, res[:parts].sum)
  end

  def test_sample02
    res = Riddle03.new('/input_sample_02.txt').call
    assert_equal(4361, res[:parts].sum)
    assert_equal([[467, 35], [755, 598]], res[:gears])
    assert_equal(467_835, res[:gears].map { |gear| gear.inject(&:*) }.sum)
  end

  def test_input02
    res = Riddle03.new('/input_02.txt').call
    assert_equal(553_825, res[:parts].sum)
    assert_equal(93_994_191, res[:gears].map { |gear| gear.inject(&:*) }.sum)
  end

  def test_group_position_of_numbers
    assert_equal(
      { 0 => { '0_2' => { fields: [[0, 0], [0, 1], [0, 2]], number: 467 },
               '5_7' => { fields: [[0, 5], [0, 6], [0, 7]], number: 114 } },
        2 => { '2_3' => { fields: [[2, 2], [2, 3]], number: 35 },
               '6_8' => { fields: [[2, 6], [2, 7], [2, 8]], number: 633 } },
        4 => { '0_2' => { fields: [[4, 0], [4, 1], [4, 2]], number: 617 } },
        5 => { '7_8' => { fields: [[5, 7], [5, 8]], number: 58 } },
        6 => { '2_4' => { fields: [[6, 2], [6, 3], [6, 4]], number: 592 } },
        7 => { '6_8' => { fields: [[7, 6], [7, 7], [7, 8]], number: 755 } },
        9 => { '1_3' => { fields: [[9, 1], [9, 2], [9, 3]], number: 664 },
               '5_7' => { fields: [[9, 5], [9, 6], [9, 7]], number: 598 } } },
      Riddle03.new('/input_sample_01.txt')
              .send(:group_positions_of_numbers, [
                      [0, 0],
                      [0, 1],
                      [0, 2],
                      [0, 5],
                      [0, 6],
                      [0, 7],
                      [2, 2],
                      [2, 3],
                      [2, 6],
                      [2, 7],
                      [2, 8],
                      [4, 0],
                      [4, 1],
                      [4, 2],
                      [5, 7],
                      [5, 8],
                      [6, 2],
                      [6, 3],
                      [6, 4],
                      [7, 6],
                      [7, 7],
                      [7, 8],
                      [9, 1],
                      [9, 2],
                      [9, 3],
                      [9, 5],
                      [9, 6],
                      [9, 7]
                    ])
    )
  end
end
