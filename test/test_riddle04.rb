# frozen_string_literal: true

require_relative 'test_helper'

class TestRiddle04 < Test::Unit::TestCase
  def test_input02
    assert_equal(7_013_204, Riddle04.new('/input_02.txt').call2)
  end

  def test_sample02
    assert_equal(30, Riddle04.new('/input_sample_01.txt').call2)
  end

  def test_input01
    assert_equal(22_488, Riddle04.new('/input_01.txt').call)
  end

  def test_prepare_cards
    assert_equal(
      { 'Card 1' => {
          card: 'Card 1',
          winning_nums: [41, 48, 83, 86, 17],
          nums: [83, 86, 6, 31, 17, 9, 48, 53],
          counter: 4,
          result: 8
        },
        'Card 2' => {
          card: 'Card 2',
          winning_nums: [13, 32, 20, 16, 61],
          nums: [61, 30, 68, 82, 17, 32, 24, 19],
          counter: 2,
          result: 2
        },
        'Card 3' => {
          card: 'Card 3',
          winning_nums: [1, 21, 53, 59, 44],
          nums: [69, 82, 63, 72, 16, 21, 14, 1],
          counter: 2,
          result: 2
        },
        'Card 4' => {
          card: 'Card 4',
          winning_nums: [41, 92, 73, 84, 69],
          nums: [59, 84, 76, 51, 58, 5, 54, 83],
          counter: 1,
          result: 1
        },
        'Card 5' => {
          card: 'Card 5',
          winning_nums: [87, 83, 26, 28, 32],
          nums: [88, 30, 70, 12, 93, 22, 82, 36],
          counter: 0,
          result: 0
        },
        'Card 6' => {
          card: 'Card 6',
          winning_nums: [31, 18, 13, 56, 72],
          nums: [74, 77, 10, 23, 35, 67, 36, 11],
          counter: 0,
          result: 0
        } }, Riddle04.new('/input_sample_02.txt').prepare_cards
    )
  end

  def test_count_cards
    assert_equal(
      { 'Card 1' => {
          card: 'Card 1',
          winning_nums: [41, 48, 83, 86, 17],
          nums: [83, 86, 6, 31, 17, 9, 48, 53]
        },
        'Card 2' => {
          card: 'Card 2',
          winning_nums: [13, 32, 20, 16, 61],
          nums: [61, 30, 68, 82, 17, 32, 24, 19]
        },
        'Card 3' => {
          card: 'Card 3',
          winning_nums: [1, 21, 53, 59, 44],
          nums: [69, 82, 63, 72, 16, 21, 14, 1]
        },
        'Card 4' => {
          card: 'Card 4',
          winning_nums: [41, 92, 73, 84, 69],
          nums: [59, 84, 76, 51, 58, 5, 54, 83]
        },
        'Card 5' => {
          card: 'Card 5',
          winning_nums: [87, 83, 26, 28, 32],
          nums: [88, 30, 70, 12, 93, 22, 82, 36]
        },
        'Card 6' => {
          card: 'Card 6',
          winning_nums: [31, 18, 13, 56, 72],
          nums: [74, 77, 10, 23, 35, 67, 36, 11]
        } },
      Riddle04.new('/input_sample_01.txt').count_cards
    )
  end

  def test_sample01
    assert_equal(13, Riddle04.new('/input_sample_01.txt').call)
  end

  def test_read_file
    assert_equal('Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53',
                 Riddle04.new('/input_sample_01.txt').send(:read_file).first)
  end

  def test_evaluate_line
    assert_equal(
      { card: 'Card 1',
        winning_nums: [41, 48, 83, 86, 17],
        nums: [83, 86, 6, 31, 17, 9, 48, 53] },
      Riddle04.new('/input_sample_01.txt').evaluate_line(
        'Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53'
      )
    )
  end
end
