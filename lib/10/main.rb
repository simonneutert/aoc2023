# frozen_string_literal: true

class Riddle10
  attr_reader :input, :data, :start

  def initialize(filename, start_symbol = 'F')
    @filename = filename
    read_file
    prepare_board
    find_start
    @start_symbol = start_symbol
  end

  def neighbors_symbols(row: @start[0], column: @start[1])
    res = {}
    neighbors(row:, column:).each.with_index do |neighbor, idx|
      direction = case idx
                  when 0
                    :top
                  when 1
                    :right
                  when 2
                    :down
                  when 3
                    :left
                  end

      symbol = @data[neighbor[0]][neighbor[1]]
      symbol = nil if neighbor.any?(&:negative?)
      res.merge!({ direction => symbol })
    end
    res
  end

  def neighbor_from_direction(direction, row, col)
    case direction
    when :top
      [row - 1, col]
    when :right
      [row, col + 1]
    when :down
      [row + 1, col]
    when :left
      [row, col - 1]
    else
      raise "Unknown direction: #{direction}"
    end
  end

  def wander
    next1 = :right
    next2 = :down
    case @start_symbol
    when 'F'
      next1 = :right
      next2 = :down
    when '7'
      next1 = :left
      next2 = :down
    when 'J'
      next1 = :left
      next2 = :top
    when 'L'
      next1 = :top
      next2 = :right
    when '|'
      next1 = :top
      next2 = :down
    when '-'
      next1 = :left
      next2 = :right
    end

    next_params = wander_loop(
      { counter: 0,
        steps: { next1:, next2: },
        positions: [@start, @start],
        path: [@start, @start] }
    )

    next_params = wander_loop(next_params) until next_params[:positions].uniq.size == 1
    next_params
  end

  def wander_loop(loop_params)
    loop_params in {
      counter:,
      steps: {next1:, next2:},
      positions: [[row1, col1], [row2, col2]],
      path: path
    }

    next1neighbor = neighbor_from_direction(next1, row1, col1)
    next2neighbor = neighbor_from_direction(next2, row2, col2)

    neighbor1_symbol = @data[next1neighbor[0]][next1neighbor[1]]
    neighbor2_symbol = @data[next2neighbor[0]][next2neighbor[1]]

    next11 = march_table.dig(next1, neighbor1_symbol)
    next22 = march_table.dig(next2, neighbor2_symbol)

    { counter: counter + 1,
      steps: { next1: next11, next2: next22 },
      positions: [next1neighbor, next2neighbor],
      path: path.push(next1neighbor, next2neighbor) }
  end

  # reads: came from `key`, pass `key` next direction next step `val`
  # @example
  # march_table.dig(:right, 'J') # => :top
  def march_table
    { right: {
        'J' => :top,
        '7' => :down,
        '-' => :right
      },
      left: {
        'L' => :top,
        'F' => :down,
        '-' => :left
      },
      top: {
        '|' => :top,
        '7' => :left,
        'F' => :right
      },
      down: {
        '|' => :down,
        'J' => :left,
        'L' => :right
      } }
  end

  def neighbors(row:, column:)
    [
      [row - 1, column], # top
      [row, column + 1], # right
      [row + 1, column], # down
      [row, column - 1] # left
    ]
  end

  def neighbors_wording(sym, row, column)
    case sym
    when :top # of
      [row - 1, column]
    when :right # of
      [row, column + 1]
    when :down # of
      [row + 1, column]
    when :left # of
      [row, column - 1]
    else
      raise "Unknown neighbor: #{sym}"
    end
  end

  def reasonable_neighbors(symbol:)
    {
      '|' => {
        down: ['|', 'J', 'L'],
        top: ['|', 'F', '7']
      },
      '-' => {
        left: ['-', 'L', 'F'],
        right: ['-', 'J', '7']
      },
      'L' => {
        top: ['|', 'F', '7'],
        right: ['-', 'J', '7']
      },
      'J' => {
        left: ['-', 'L', 'F'],
        top: ['|', 'F', '7']
      },
      '7' => {
        left: ['-', 'L', 'F'],
        down: ['|', 'J', 'L']
      },
      'F' => {
        down: ['|', 'J', 'L'],
        right: ['-', 'J', '7']
      }
    }.fetch(symbol, nil)
  end

  private

  def prepare_board
    @data = @input.map(&:chars)
  end

  def find_start
    r = @data.find { |row| row.include?('S') }
    @start = [@data.index(r), r.index('S')]
  end

  def read_file
    @input = File.read(File.path(__dir__) + @filename).split("\n")
  end
end
