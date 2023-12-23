# frozen_string_literal: true

class Riddle01
  def initialize(filename)
    @filename = filename
    readfile
  end

  def call(detect_words: false)
    @input.reduce(0) do |agg, line|
      if detect_words
        detect_words(agg, line)
      else
        agg + aggregate_collection(line.gsub(/\d/).to_a)
      end
    end
  end

  private

  def aggregate_collection(coll)
    case coll.size
    when 0
      0
    when 1
      "#{coll.first}#{coll.first}".to_i
    else
      "#{coll.first}#{coll.last}".to_i
    end
  end

  def detect_words(agg, line)
    i = 0
    coll = []
    line_split = line.chars
    if line_split.first.to_i.positive? && line_split.last.to_i.positive?
      coll << line_split.first.to_i
      coll << line_split.last.to_i
    else
      while line_split[i]
        char = line_split[i]
        if line_split[i, 3] == %w[o n e]
          coll << 1
        elsif line_split[i, 3] == %w[t w o]
          coll << 2
        elsif line_split[i, 3] == %w[s i x]
          coll << 6
        elsif line_split[i, 5] == %w[s e v e n]
          coll << 7
        elsif line_split[i, 5] == %w[e i g h t]
          coll << 8
        elsif line_split[i, 5] == %w[t h r e e]
          coll << 3
        elsif line_split[i, 4] == %w[f o u r]
          coll << 4
        elsif line_split[i, 4] == %w[f i v e]
          coll << 5
        elsif line_split[i, 4] == %w[n i n e]
          coll << 9
        elsif char.to_i.positive?
          coll << char.to_i
        end
        i += 1
      end
    end

    agg + aggregate_collection(coll)
  end

  def readfile
    @input = File.read(File.path(__dir__) + @filename).split("\n")
  end
end
