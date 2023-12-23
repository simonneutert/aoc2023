# frozen_string_literal: true

class Riddle04
  def initialize(filename)
    @filename = filename
    read_file
  end

  def call
    evaluate_lines.map { |res| res[:result] }.sum
  end

  def prepare_cards
    result = {}
    counted_cards = Marshal.load(Marshal.dump(count_cards))
    lines = evaluate_lines

    counted_cards.each_key.with_index do |card, i|
      result.merge!({ card => counted_cards[card].merge(lines[i]) })
    end
    result
  end

  def call2
    result = prepare_cards

    result.each_key do |card|
      result[card].merge!({ dup: 1 })
    end

    res_k = result.keys.reverse
    while (card = res_k.pop)
      res_k.last(result[card][:counter]).each do |c|
        result[c][:dup] += 1 * result[card][:dup]
      end
    end

    result.map { |_, v| v[:dup] }.sum
  end

  def count_cards
    @input.map { |line| evaluate_line(line) }.each_with_object({}) do |h, agg|
      agg[h[:card]] = h
    end
  end

  def evaluate_lines
    @input.map do |line|
      res = evaluate_line(line)
      win = res[:winning_nums].count
      counter = win - (res[:winning_nums] - res[:nums]).count

      result = case counter
               when 1
                 1
               when 0
                 0
               else
                 1 << (counter - 1)
               end
      { counter:, result: }
    end
  end

  def evaluate_line(line)
    games, nums = line.split(':')
    winning_nums, nums = nums.split('|')
    winning_nums = winning_nums.split.map(&:to_i)
    nums = nums.split.map(&:to_i)
    { card: games, winning_nums:, nums: }
  end

  private

  def read_file
    @input = File.read(File.path(__dir__) + @filename).split("\n")
  end
end
