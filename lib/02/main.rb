# frozen_string_literal: true

class Riddle02
  def initialize(filename)
    @filename = filename
    read_file
  end

  def rules
    {
      'red' => 12,
      'green' => 13,
      'blue' => 14
    }
  end

  def call1
    prepare_draws.reduce(0) do |agg, (game, draws)|
      evaluate_game({ game => draws }, rules) ? agg + game : agg
    end
  end

  def call2
    prepare_draws.reduce(0) do |agg, (game, draws)|
      aggregated_max_counts = aggregate_max_from_draws({ game => draws }).map { |_color, count| count }
      agg + aggregated_max_counts.reduce(:*)
    end
  end

  private

  def aggregate_max_from_draws(data, agg = {})
    data.each_value do |draws|
      draws[:draws].each_key do |draw|
        draws[:draws][draw].each do |color, count|
          agg[color] ||= 0
          agg[color] = count if count > agg[color]
        end
      end
    end
    agg
  end

  def evaluate_game(data, rules)
    res = true
    data.each_value do |draws|
      draws[:draws].each_key do |draw|
        draws[:draws][draw].each do |color, count|
          next unless rules[color]

          if count > rules[color]
            res = false
            break
          end
        end
      end
      break if res == false
    end
    res
  end

  def prepare_draws
    @input.each_with_object({}) do |line, agg|
      game = line.split(':').first.gsub(/\d/).to_a.join.to_i
      agg[game] ||= {}
      draws_text = line.split(':').last.split(';').map(&:strip)
      agg[game][:draws] = {}
      draws_text.each.with_index do |draw, i|
        agg[game][:draws][i] = {}
        cubes_color = draw.split(', ')
        cubes_color.each do |cube_color|
          cube_count, color = cube_color.split
          agg[game][:draws][i][color] ||= 0
          agg[game][:draws][i][color] += cube_count.to_i
        end
        agg
      end
    end
  end

  def read_file
    @input = File.read(File.path(__dir__) + @filename).split("\n")
  end
end
