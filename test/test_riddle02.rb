# frozen_string_literal: true

require_relative 'test_helper'

class TestRiddle02 < Test::Unit::TestCase
  def test_input02
    assert_equal(67_335, Riddle02.new('/input_02.txt').call2)
  end

  def test_sample_input02
    assert_equal(2286, Riddle02.new('/input_sample_02.txt').call2)
  end

  def test_max_from_draws
    assert_equal({ 'red' => 4, 'green' => 2, 'blue' => 6 },
                 Riddle02.new('/input_sample_01.txt')
                 .send(:aggregate_max_from_draws,
                       { 1 => { draws: {
                         0 => { 'blue' => 3, 'red' => 4 },
                         1 => { 'blue' => 6, 'green' => 2, 'red' => 1 },
                         2 => { 'green' => 2 }
                       } } }))
  end

  def test_input01
    assert_equal(2512, Riddle02.new('/input_01.txt').call1)
  end

  def test_sample1
    assert_equal(8, Riddle02.new('/input_sample_01.txt').call1)
  end

  def test_rules
    assert_equal(
      { 'red' => 12, 'green' => 13, 'blue' => 14 },
      Riddle02.new('/input_sample_01.txt').rules
    )
  end

  def test_prepare_draws
    assert_equal({ 1 =>
    { draws: { 0 => { 'blue' => 3, 'red' => 4 },
               1 => { 'blue' => 6, 'green' => 2, 'red' => 1 },
               2 => { 'green' => 2 } } },
                   2 =>
    { draws: { 0 => { 'blue' => 1, 'green' => 2 },
               1 => { 'blue' => 4, 'green' => 3, 'red' => 1 },
               2 => { 'blue' => 1, 'green' => 1 } } },
                   3 =>
    { draws: { 0 => { 'blue' => 6, 'green' => 8, 'red' => 20 },
               1 => { 'blue' => 5, 'green' => 13, 'red' => 4 },
               2 => { 'green' => 5, 'red' => 1 } } },
                   4 =>
    { draws: { 0 => { 'blue' => 6, 'green' => 1, 'red' => 3 },
               1 => { 'green' => 3, 'red' => 6 },
               2 => { 'blue' => 15, 'green' => 3, 'red' => 14 } } },
                   5 =>
    { draws: { 0 => { 'blue' => 1, 'green' => 3, 'red' => 6 },
               1 => { 'blue' => 2, 'green' => 2,
                      'red' => 1 } } } }, Riddle02.new('/input_sample_01.txt').send(:prepare_draws))
  end
end
