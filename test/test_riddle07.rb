# frozen_string_literal: true

require_relative 'test_helper'

class TestRiddle07 < Test::Unit::TestCase
  def test_evaluate_game01
    service = Riddle07.new('/input_01.txt')
    assert_equal(248_179_786, service.evaluate_game)
  end

  def test_evaluate_game_sample01
    service = Riddle07.new('/input_sample_01.txt')
    assert_equal(6440, service.evaluate_game)
  end

  def test_evaluate_game01b
    service = Riddle07.new('/input_01.txt')
    service.joker_game = true
    assert_equal(247_885_995, service.evaluate_game)
  end

  def test_evaluate_game_sample01b
    service = Riddle07.new('/input_sample_01.txt')
    service.joker_game = true
    assert_equal(5905, service.evaluate_game)
  end
end
