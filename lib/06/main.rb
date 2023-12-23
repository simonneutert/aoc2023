# frozen_string_literal: true

class Riddle06
  attr_reader :data, :joined_data

  def initialize(filename)
    @filename = filename
    read_file
    prepare_data
  end

  def product_of_possible_ways_to_win
    @data.map { |vector| calculate_possible_ways_to_win(vector) }.reduce(:*)
  end

  def calculate_possible_ways_to_win(vector)
    time_to_beat = vector[1]

    starting_result = (1..(vector[0])).bsearch { |load| ((vector[0] - load) * load) > time_to_beat }
    last_result = (starting_result..(vector[0])).bsearch { |load| ((vector[0] - load) * load) <= time_to_beat }
    last_result - starting_result
  end

  def prepare_data
    prepped_arrays = @input.map { |line| line.split(':').last.strip }.map(&:split).map { |l| l.map(&:to_i) }
    @joined_data = prepped_arrays.map(&:join).map(&:to_i)
    prepped_arrays.join
    @data = prepped_arrays[0].zip(prepped_arrays[1])
  end

  private

  def read_file
    @input = File.read(File.path(__dir__) + @filename).split("\n")
  end
end
