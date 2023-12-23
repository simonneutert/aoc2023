# frozen_string_literal: true

class Riddle08
  attr_reader :instructions, :nodes, :node_table

  def initialize(filename)
    @filename = filename
    read_file
    prepare_data
  end

  def test_multi_walk
    currents = {}
    starting_points = @node_table.keys.grep(/\w\wA/)

    i = @instructions.cycle
    count = 0
    starting_points.each do |start|
      currents[count] ||= []
      currents[count] = currents[count] << start
    end

    breaking_condition = []
    until currents[count].all? { |c| c.end_with?('Z') }
      if currents.keys.size > 5
        breaking_condition = []
        currents.each_key do |k|
          currents[k].each.with_index do |current, i|
            breaking_condition << i if current.end_with?('Z')
          end
        end

        break if breaking_condition.uniq.sort == [0, 1, 2, 3, 4, 5]
      end

      step = i.next.downcase.to_sym

      currents[count].each do |current|
        currents[count + 1] ||= []
        currents[count + 1] << @node_table[current][step.downcase.to_sym]
      end
      count += 1
      currents.delete(count - 1) unless currents[count - 1].any? { |c| c.end_with?('Z') }
    end

    coll = []
    starting_points.size.times do |idx_step|
      coll << currents.select { |k, v| k if v[idx_step].end_with?('Z') }.first[0]
    end

    coll.reduce(1) { |acc, e| acc.lcm(e) }
  end

  def walk(start = 'AAA', target = /ZZZ/)
    current = start

    i = @instructions.cycle
    count = 0
    until current.match?(target)
      count += 1
      step = i.next.downcase.to_sym
      current = @node_table[current][step.downcase.to_sym]
    end
    count
  end

  def prepare_data
    @instructions = @input[0].chars
    @nodes = @input[2..]
    @node_table = {}
    @nodes.each do |line|
      node, path = line.split('=').map(&:strip)
      left, right = path.split(',')
      right = right.gsub('(', '').gsub(')', '').strip
      left = left.gsub('(', '').gsub(')', '').strip

      @node_table[node] = { r: right, l: left }
    end
  end

  private

  def read_file
    @input = File.read(File.path(__dir__) + @filename).split("\n")
  end
end
