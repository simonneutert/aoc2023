# frozen_string_literal: true

class Riddle09
  attr_reader :input

  def initialize(filename)
    @filename = filename
    read_file
    prepare_data!
  end

  def find_prev
    @input.map do |line|
      # for every line
      find_prev_line(line)
    end
  end

  def find_prev_line(line)
    line_table = {}
    runner = 1
    coll = []
    until !coll.empty? && coll.all?(&:zero?)
      coll = line if coll.empty?
      coll = find_steps(coll)
      line_table[runner] = coll[0, 2].dup
      runner += 1
    end
    line_table[0] = line[0, 2]
    k = line_table.keys.max

    until k.zero?
      last_track = line_table[k - 1].first - line_table[k].first
      line_table[k - 1] = [last_track] + line_table[k - 1]
      k -= 1
    end

    line[0] - line_table[1].first
  end

  def find_next
    @input.map do |line|
      # for every line
      line_table = {}
      runner = 1
      coll = []
      until !coll.empty? && coll.all?(&:zero?)
        coll = line if coll.empty?
        coll = find_steps(coll)
        line_table[runner] = coll[-2..].dup
        runner += 1
      end
      line_table[0] = line[-2..]

      line_table.keys.sort.reverse
      keys_max = line_table.keys.max
      init_val = line_table.delete(keys_max).last + line_table.delete(keys_max - 1).last

      k = line_table.keys.max
      last_track = init_val
      until k.zero?
        last_track = line_table[k].last + last_track
        line_table[k] = line_table[k] += [last_track]
        k -= 1
      end
      line_table[0].last + last_track
    end
  end

  def prepare_data!
    @input.map! { |line| line.split.map(&:to_i) }
  end

  def find_steps(arr)
    coll = []
    arr.each.with_index do |num, index|
      next unless arr[index + 1]

      coll << (arr[index + 1] - num)
    end
    coll
  end

  private

  def read_file
    @input = File.read(File.path(__dir__) + @filename).split("\n")
  end
end
