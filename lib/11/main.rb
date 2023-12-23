# frozen_string_literal: true

class Riddle11
  attr_reader :input, :gal, :data, :items, :empty_rows, :empty_cols
  attr_accessor :factor

  def initialize(filename)
    @filename = filename
    read_file
    read_data
    find_items('#')
    @factor = 2
  end

  def calculate_distances
    res = {}
    @items.each do |item1|
      @items.each do |item2|
        new_k = [item1, item2].sort.join('-')
        next if item1 == item2

        distance = calculate_distance(item1, item2)
        res[new_k] ||= distance
      end
    end
    res
  end

  def calculate_distance(item1, item2, factor = @factor)
    factor ||= 1
    item1 in [item1row, item1col]
    item2 in [item2row, item2col]

    factor_col = @empty_cols.filter_map do |col|
      1 if (([item1col, item2col].min)..([item1col, item2col].max)).include?(col)
    end.sum
    factor_row = @empty_rows.filter_map do |row|
      1 if (([item1row, item2row].min)..([item1row, item2row].max)).include?(row)
    end.sum

    row = (item1row - item2row).abs + (factor_row * factor) - factor_row
    col = (item1col - item2col).abs + (factor_col * factor) - factor_col

    row + col
  end

  def find_items(item)
    @items = []
    @input.each_with_index do |line, line_idx|
      line.chars.each_with_index do |char, col_idx|
        @items << [line_idx, col_idx] if char == item
      end
    end
    @items
  end

  def read_data
    @empty_rows = []
    @empty_cols = []

    @input.each.with_index do |row, idx|
      @empty_rows << idx unless row.include?('#')
    end
    @input.map(&:chars).transpose.map(&:join).each.with_index do |col, idx|
      @empty_cols << idx unless col.include?('#')
    end
  end

  private

  def read_file
    @input = File.read(File.path(__dir__) + @filename).split("\n")
  end
end
