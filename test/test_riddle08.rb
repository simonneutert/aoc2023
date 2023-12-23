# frozen_string_literal: true

require_relative 'test_helper'

class TestRiddle08 < Test::Unit::TestCase
  def test_multi_walk02
    service = Riddle08.new('/input_02.txt')
    assert_equal(12_357_789_728_873, service.test_multi_walk)
  end

  def test_multi_walk_sample02
    service = Riddle08.new('/input_sample_02.txt')
    assert_equal(6, service.test_multi_walk)
  end

  def test_node_table_sample01
    service = Riddle08.new('/input_sample_01.txt')
    assert_equal(
      { 'AAA' => { l: 'BBB', r: 'BBB' },
        'BBB' => { l: 'AAA', r: 'ZZZ' },
        'ZZZ' => { l: 'ZZZ', r: 'ZZZ' } }, service.node_table
    )
  end

  def test_node_table_size_sample01
    service = Riddle08.new('/input_sample_01.txt')
    assert_equal(
      3, service.node_table.keys.size
    )
  end

  def test_walk_sample01
    service = Riddle08.new('/input_sample_01.txt')
    assert_equal(6, service.walk)
  end

  def test_node_table_size01
    service = Riddle08.new('/input_01.txt')
    assert_equal(
      726, service.node_table.keys.size
    )
  end

  def test_walk01
    service = Riddle08.new('/input_01.txt')
    assert_equal(24_253, service.walk)
  end
end
