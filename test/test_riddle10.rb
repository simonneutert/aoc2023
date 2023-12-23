# frozen_string_literal: true

require_relative 'test_helper'

class TestRiddle10 < Test::Unit::TestCase
  def test_wander_loop_sample1
    service = Riddle10.new('/input_sample_01.txt')
    res = service.wander_loop(
      { counter: 0,
        steps: { next1: :right, next2: :down },
        positions: [[2, 0], [2, 0]],
        path: [service.start, service.start] }
    )
    assert_equal(
      { counter: 1,
        path: [[2, 0], [2, 0], [2, 1], [3, 0]],
        positions: [[2, 1], [3, 0]],
        steps: { next1: :top, next2: :down } },
      res
    )
  end

  # def test_wander_cluster02
  #   service = Riddle10.new('/input_01.txt', 'F')
  #   path = service.wander[:path].uniq
  #   max_col = service.data.first.size
  #   max_row = service.data.size

  #   cluster = []

  #   path_set = Set.new(path)

  #   path.each do |pos|
  #     row = pos[0]
  #     col = pos[1]
  #     next if col == max_col || row == max_row
  #     next if col.zero? || row.zero?

  #     pointer = col + 1
  #     pointer += 1 until path.include?([row, pointer + 1]) || pointer == max_col
  #     next if pointer == max_col || pointer + 1 == max_col

  #     (col..pointer).each do |c|
  #       cluster << [row, c]
  #     end
  #     cluster.reject! { |c| path_set.include?(c) }
  #   end

  #   assert_equal(0, cluster.uniq.size)
  # end

  def test_wander_sample_cluster02
    service = Riddle10.new('/input_sample_02.txt', '7')
    path = service.wander[:path].uniq
    max_col = service.data.first.size
    max_row = service.data.size

    cluster = []

    path_set = Set.new(path)

    outside = []
    (0..max_row).each do |row|
      (0..max_col).each do |col|
        outside << [row, col] unless path_set.include?([row, col])
      end
    end

    path.each do |pos|
      row = pos[0]
      col = pos[1]
      next if col == max_col || row == max_row
      next if col.zero? || row.zero?

      pointer = col + 1
      pointer += 1 until path.include?([row, pointer + 1]) || pointer == max_col

      next if pointer == max_col

      (col..pointer).each do |c|
        cluster << [row, c]
      end
      cluster.reject! { |c| path_set.include?(c) }
    end

    assert_equal(10, cluster.uniq.size)
  end

  def test_wander_sample1
    service = Riddle10.new('/input_sample_01.txt')
    assert_equal(8, service.wander[:counter])
  end

  def test_wander01
    service = Riddle10.new('/input_01.txt')
    assert_equal(6690, service.wander[:counter])
  end

  def test_neighbors_symbols
    service = Riddle10.new('/input_sample_01.txt')
    assert_equal(
      { top: 'J', right: 'J', down: '|', left: nil },
      service.neighbors_symbols
    )
  end

  def test_find_start
    service = Riddle10.new('/input_sample_01.txt')
    assert_equal([2, 0], service.start)
  end

  def test_start_neighbors
    service = Riddle10.new('/input_sample_01.txt')

    assert_equal(
      [[1, 0], [2, 1], [3, 0], [2, -1]],
      service.neighbors(row: service.start[0], column: service.start[1])
    )
  end
end
