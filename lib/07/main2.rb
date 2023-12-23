# frozen_string_literal: true

class Riddle07b
  LOWEST_CARD_VALUE = 2

  def initialize(filename)
    @filename = filename
    read_file
  end

  def evaluate_game
    res = evaluate_round(@input.map do |line|
      hand_with_bid = line.split
      hand_with_bid[1] = hand_with_bid[1].to_i
      hand_with_bid
    end)
    agg = []
    res = res.group_by { |g| g[:hand_value] }
    res.each_key do |hand_value|
      agg.concat(res[hand_value].sort_by { |x| [x[:hand].map { |y| y }] })
    end

    result = agg.map.with_index(1) do |hand, factor|
      hand[:bid] * factor
    end
    result.sum
  end

  def evaluate_round(hands_with_bids)
    raise ArgumentError unless hands_with_bids.is_a?(Array)

    games = hands_with_bids.map do |hand_with_bid|
      hand, bid = hand_with_bid
      hand = hand.chars
      evaluate_player_hand(hand).merge!(bid:)
    end

    games.sort_by { |g| [g[:hand_value], g[:game]] }.map.with_index(1) do |game, factor|
      game.merge(result: game[:bid] * factor)
    end
  end

  def evaluate_player_hand(hand)
    r = hand_ratios(hand)
    evaluated_hand = eval_hand(r)
    hand_value = evaluated_hand[:value]
    cards_value = eval_cards(r)

    { hand_value:, cards_value:, evaluated_hand:, hand: hand.map { |c| eval_card(c) } }
  end

  def card_values
    %w[A K Q T 9 8 7 6 5 4 3 2 J]
  end

  def card_values_number(card)
    card_values.reverse.index(card) + LOWEST_CARD_VALUE
  end

  def eval_hand(hand_ratio)
    if five(hand_ratio)
      { value: 9, hand_ratio: }
    elsif four(hand_ratio)
      { value: 8, hand_ratio: }
    elsif full_house?(hand_ratio)
      { value: 7, hand_ratio: }
    elsif three(hand_ratio)
      { value: 6, hand_ratio: }
    elsif double_pair?(hand_ratio)
      { value: 5, hand_ratio: }
    elsif one_pair?(hand_ratio)
      { value: 4, hand_ratio: }
    else
      { value: 3, hand_ratio: }
    end
  end

  def eval_card(card)
    card_values_number(card)
  end

  def eval_cards(res)
    res.keys.map { |k| eval_card(k) * res[k] }.sum
  end

  def hand_ratios(hand)
    res = hand.each_with_object({}) do |card, acc|
      acc[card] ||= 0
      acc[card] += 1
    end

    res = res.sort_by { |_, v| -v }.to_h

    if res.keys.include?('J')
      jokers = res.delete('J')
      if jokers == 5
        res = { 'A' => jokers }
      elsif jokers == 4
        res.merge!({ res.keys.first => 5 })
      else

        highest_card = res.sort_by { |k, v| [-v, eval_card(k) * -1] }.to_h.keys.first
        res.merge!({ highest_card => res[highest_card] + jokers })
        # {"A" => 3, "5"=>3, "T"=>1}.sort_by { |k, v| [-v, eval_card(k) * -1] }.to_h #=> {"A"=>3, "5"=>3, "T"=>1}
      end
    end
    res
  end

  def full_house?(hand_ratio)
    hand_ratio.values.sort == [2, 3]
  end

  def three(hand_ratio)
    hand_ratio.values.sort == [1, 1, 3]
  end

  def five(hand_ratio)
    hand_ratio.values == [5]
  end

  def four(hand_ratio)
    hand_ratio.values.sort == [1, 4]
  end

  def one_pair?(hand_ratio)
    hand_ratio.values.sort == [1, 1, 1, 2]
  end

  def double_pair?(hand_ratio)
    hand_ratio.values.sort == [1, 2, 2]
  end

  private

  def read_file
    @input = File.read(File.path(__dir__) + @filename).split("\n")
  end
end
