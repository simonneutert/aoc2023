# frozen_string_literal: true

class Riddle03
  attr_reader :input

  def initialize(filename)
    @filename = filename
    read_file
  end

  def call
    position_of_numbers = []
    positions_of_symbols = []
    positions_of_star_symbols = []
    @input.each.with_index do |line, line_index|
      line.each_char.with_index do |char, char_index|
        position_of_numbers << [line_index, char_index] if char.match?(/\d/)
        positions_of_symbols << [line_index, char_index] if char_symbol_not_dot?(char)
        positions_of_star_symbols << [line_index, char_index] if char_star_not_dot?(char)
      end
    end

    grouped_positions_of_numbers = group_positions_of_numbers(position_of_numbers)

    parts = find_valid_parts(deep_copy(grouped_positions_of_numbers), positions_of_symbols)
    parts = parts.filter_map { |num| num if num.positive? }.sort

    gears = find_gears(deep_copy(grouped_positions_of_numbers), positions_of_star_symbols)

    { parts:, gears: }
  end

  private

  def neighbours(position_of_symbols)
    raise ArgumentError unless position_of_symbols.is_a?(Array)

    line_index, char_index = position_of_symbols
    [[line_index - 1, char_index - 1], [line_index - 1, char_index], [line_index - 1, char_index + 1],
     [line_index, char_index - 1],                                   [line_index, char_index + 1],
     [line_index + 1, char_index - 1], [line_index + 1, char_index], [line_index + 1, char_index + 1]]
  end

  def deep_copy(obj)
    Marshal.load(Marshal.dump(obj))
  end

  def find_gears(grouped_positions_of_numbers, positions_of_star_symbols)
    numbers = []

    positions_of_star_symbols.each do |position_of_symbol|
      num = []
      neighbours(position_of_symbol).each do |(line_index, char_index)|
        next if line_index.negative? || char_index.negative?
        next unless grouped_positions_of_numbers[line_index]

        grouped_positions_of_numbers[line_index].each_value do |v|
          next unless v[:fields].include?([line_index, char_index])

          num << v[:number].dup unless v[:number].zero?
          v[:number] = 0
        end
      end
      numbers << num
    end
    numbers.filter_map { |num| num if num.size >= 2 }
  end

  def find_valid_parts(grouped_positions_of_numbers, positions_of_symbols)
    numbers = []
    positions_of_symbols.each do |position_of_symbol|
      neighbours(position_of_symbol).each do |(line_index, char_index)|
        next if line_index.negative? || char_index.negative?
        next unless grouped_positions_of_numbers[line_index]

        grouped_positions_of_numbers[line_index].each_value do |v|
          next unless v[:fields].include?([line_index, char_index])

          numbers << v[:number].dup
          v[:number] = 0
        end
      end
    end
    numbers
  end

  def group_positions_of_numbers(position_of_numbers)
    grouped_digits_in_index_table = {}
    position_of_numbers.group_by(&:first).each do |line_index, positions|
      aggregate_line_digits(grouped_digits_in_index_table, line_index, positions)
    end

    grouped_digits_in_index_table
  end

  def aggregate_line_digits(grouped_digits_in_index_table, line_index, positions)
    return unless positions.any?

    coll = []
    previous_position = nil
    grouped_digits_in_index_table[line_index] = {}

    positions.flat_map(&:last).each do |position|
      previous_position = position - 1 if previous_position.nil?

      if previous_position + 1 == position
        coll << position
      else
        aggregate_collected_digits(grouped_digits_in_index_table, coll, line_index)
        coll = [position]
      end
      previous_position = position
    end

    aggregate_collected_digits(grouped_digits_in_index_table, coll, line_index)
  end

  def aggregate_collected_digits(number_positions, coll, line_index)
    raise ArgumentError unless coll.is_a?(Array)
    raise ArgumentError unless line_index.is_a?(Integer)
    raise ArgumentError unless number_positions.is_a?(Hash)

    k = "#{coll.first}_#{coll.last}"
    return unless k != '_'

    number_positions[line_index][k] = {}
    number_positions[line_index][k][:fields] = coll.map { |c| [line_index, c] }
    number_positions[line_index][k][:number] = coll.map { |c| @input[line_index][c] }.join.to_i
  end

  def char_symbol_not_dot?(char)
    char.match?(/\D/) && char != '.'
  end

  def char_star_not_dot?(char)
    char.match?(/\*/) && char != '.'
  end

  def read_file
    @input = File.read(File.path(__dir__) + @filename).split("\n")
  end
end
