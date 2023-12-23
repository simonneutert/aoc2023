# frozen_string_literal: true

require_relative 'test_helper'

class TestRiddle05 < Test::Unit::TestCase
  # def test_call02
  #   q = Queue.new
  #   service = Riddle05.new('/input_02.txt')

  #   instructions = service.build_instructions
  #   lambda_instructions = service.multi_lambda(instructions)

  #   instructions_reversed = Marshal.load(Marshal.dump(instructions)).reverse
  #   lamba_instructions_reversed = service.multi_lambda(instructions_reversed)

  #   seed_ranges = service.seeds.each_slice(2).to_a
  #   seeds = seed_ranges.map { |(start, times)| (start...(start + times)) }.flatten
  #   binding.pry
  #   # assert_equal(78, service.calculate_seed(46, lamba_instructions_reversed))
  #   results = []
  #   seeds.shuffle.each do |seed_range|
  #     puts "seed_range: #{seed_range}"
  #     [
  #       (seed_range.min..(seed_range.max / 8)),
  #       ((seed_range.max / 8)..(seed_range.max / 4)),
  #       ((seed_range.max / 4)..(seed_range.max / 2)),
  #       ((seed_range.max / 2)..seed_range.max)
  #     ].each do |subrange|
  #       q << Thread.new do
  #         res = nil
  #         puts "subrange: #{subrange}"
  #         subrange.each do |seed|
  #           location = service.calculate_seed(seed, lambda_instructions)
  #           res = location if res.nil?
  #           if location < res
  #             puts res
  #             res = location
  #           end
  #         end
  #         res
  #       end
  #     end
  #   end

  #   pool_size = 6
  #   puts "pool_size: #{pool_size}"
  #   puts "q.size: #{q.size}"
  #   until q.empty?
  #     workers = []
  #     pool_size.times do
  #       workers << q.pop
  #       puts "q.size: #{q.size}"
  #     end
  #     results << workers.map(&:value)
  #   end

  #   binding.pry
  #   assert_equal(
  #     0,
  #     results.min
  #   )
  # end

  def test_call02_reverse
    service = Riddle05.new('/input_sample_02.txt')
    instructions_reversed = service.build_instructions.reverse
    lamba_instructions = service.multi_lambda(instructions_reversed)
    assert_equal(78, service.calculate_seed(46, lamba_instructions))
    assert_equal(78, service.calculate_seed(46, lamba_instructions))
  end

  def test_sample_call
    service = Riddle05.new('/input_sample_01.txt')
    assert_equal(35, service.call)
  end

  def test_call01
    service = Riddle05.new('/input_01.txt')
    assert_equal(525_792_406, service.call)
  end

  def test_sample_02_lambdas
    service = Riddle05.new('/input_sample_02.txt')
    instructions = service.build_instructions

    assert_equal(50, service.transform_to_lamba([50, 98, 2]).call(98))
    assert_equal(51, service.transform_to_lamba([50, 98, 2]).call(99))
    assert_equal(100, service.transform_to_lamba([50, 98, 2]).call(100))

    lamba_instructions = service.multi_lambda(instructions)
    assert_equal(35, service.calculate_seed(13, lamba_instructions))
  end

  def test_sample_02_build_lambda_map
    service = Riddle05.new('/input_sample_02.txt')
    instructions = service.build_instructions
    lamba_instructions = service.multi_lambda(instructions)

    assert_equal(46, service.calculate_seed(82, lamba_instructions))

    seed_ranges = service.seeds.each_slice(2).to_a
    seeds = seed_ranges.map { |(start, times)| (start...(start + times)) }.flatten

    result = Float::INFINITY
    seeds.each do |seed_range|
      seed_range.each do |seed|
        x = service.calculate_seed(seed, lamba_instructions)
        result = x if x < result
      end
    end
    assert_equal(
      46,
      result
    )
  end

  def test_find_seeds
    service = Riddle05.new('/input_sample_01.txt')
    assert_equal([79, 14, 55, 13], service.seeds)
    assert_equal(
      [
        ['seed-to-soil map:', '50 98 2', '52 50 48'],
        ['soil-to-fertilizer map:', '0 15 37', '37 52 2', '39 0 15'],
        ['fertilizer-to-water map:', '49 53 8', '0 11 42', '42 0 7', '57 7 4'],
        ['water-to-light map:', '88 18 7', '18 25 70'],
        ['light-to-temperature map:', '45 77 23', '81 45 19', '68 64 13'],
        ['temperature-to-humidity map:', '0 69 1', '1 0 69'],
        ['humidity-to-location map:', '60 56 37', '56 93 4']
      ],
      service.coll
    )
  end

  def test_seed_soil_map
    service = Riddle05.new('/input_sample_01.txt')

    res = service.build_mapping_step([[50, 98, 2], [52, 50, 48]], 98)
    assert_equal({ y: 50 }, service.get_from_x_y_map(res, :x, 98))

    res = service.build_mapping_step([[50, 98, 2], [52, 50, 48]], 79)
    assert_equal({ y: 81 }, service.get_from_x_y_map(res, :x, 79))

    res = service.build_mapping_step([[50, 98, 2], [52, 50, 48]], 0)
    assert_equal({ y: 0 }, service.get_from_x_y_map(res, :x, 0))

    res = service.build_mapping_step([[50, 98, 2], [52, 50, 48]], 49)
    assert_equal({ y: 49 }, service.get_from_x_y_map(res, :x, 49))

    res = service.build_mapping_step([[50, 98, 2], [52, 50, 48]], 99)
    assert_equal({ y: 51 }, service.get_from_x_y_map(res, :x, 99))

    res = service.build_mapping_step([[50, 98, 2], [52, 50, 48]], 50)
    assert_equal({ y: 52 }, service.get_from_x_y_map(res, :x, 50))

    res = service.build_mapping_step([[50, 98, 2], [52, 50, 48]], 14)
    assert_equal({ y: 14 }, service.get_from_x_y_map(res, :x, 14))

    res = service.build_mapping_step([[50, 98, 2], [52, 50, 48]], 55)
    assert_equal({ y: 57 }, service.get_from_x_y_map(res, :x, 55))

    res = service.build_mapping_step([[50, 98, 2], [52, 50, 48]], 13)
    assert_equal({ y: 13 }, service.get_from_x_y_map(res, :x, 13))
  end
end
