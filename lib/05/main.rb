# frozen_string_literal: true

class Riddle05
  attr_reader :seeds, :coll, :quick_math

  def initialize(filename)
    @filename = filename
    @quick_math = []
    read_file
    @seeds = find_seeds.first.split(':').last.strip.split.filter_map(&:to_i)
    @coll = prepare_input
  end

  def call(seeds = @seeds)
    instructions = build_instructions
    running_elem = 0
    min_val = nil
    seeds.each do |seed|
      running_elem = seed
      instructions.each do |instruction|
        build_mapping_step(instruction, running_elem).each do |step|
          running_elem = get_from_x_y_map({ step.first => step.last }, :x, running_elem)[:y]
        end
      end
      min_val ||= running_elem
      min_val = running_elem if running_elem < min_val
    end
    min_val
  end

  def build_instructions
    instructions = @coll.map { |c| c[1..] }
    instructions.map! { |elem| elem.map { |e| e.split.map(&:to_i) } }
  end

  def build_mapping_step(instruction, stopper = nil)
    table = { x: {}, y: {} }

    instruction.each do |e|
      apply_x_y_map!(table, stopper, *e)
    end
    table
  end

  def prepare_input
    coll = []
    group = []

    @input.each do |line|
      next if line.match?(/seeds/)

      group << line
      next unless line == ''

      coll << group unless group.empty?
      group = []
    end

    coll << group unless group.empty?

    coll.map { |a| a.reject!(&:empty?) }
    coll.reject!(&:empty?)
  end

  def apply_x_y_map!(hsh, stopper, target, start, times)
    return hsh if stopper && (start > stopper || start + times < stopper)
    return hsh if start + times == stopper

    if stopper == start
      hsh[:x].merge!({ stopper => { y: target } })
    else
      i = stopper - start
      hsh[:x].merge!({ stopper => { y: target + i } })
    end

    hsh
  end

  def get_from_x_y_map(hsh, x_or_y_sym, val)
    res = hsh.dig(x_or_y_sym, val)
    return res if res

    case x_or_y_sym
    when :x
      { y: val }
    when :y
      { x: val }
    end
  end

  def multi_lambda(instructions)
    instructions.map { |e| e.map { |i| transform_to_lamba(i) } }
  end

  def calculate_seed(seed, lambda_instructions)
    res = seed.dup
    lambda_instructions.each do |step|
      res_before = res
      next unless @quick_math.any? { |range| range.include?(res) }

      step.each do |lbd|
        break if res_before != res

        res = lbd.call(res)
      end
    end
    res
  end

  def transform_to_lamba(instruction)
    target, start, times = instruction
    @quick_math << (start..(times + start))
    lambda { |x|
      if x >= start && x < start + times
        x + (target - start)
      else
        x
      end
    }
  end

  private

  def find_seeds
    @input.filter { |line| line.match?(/seeds/) }
  end

  def read_file
    @input = File.read(File.path(__dir__) + @filename).split("\n")
  end
end
