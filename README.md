# Advent of Code 2023 🎄🎅

[![Ruby](https://github.com/simonneutert/aoc2023/actions/workflows/ruby.yml/badge.svg)](https://github.com/simonneutert/aoc2023/actions/workflows/ruby.yml)

```bash
$ bundle install
$ bundle exec rake test
```

This time with `Test::Unit` 🥳 as the Testing Framework.

## Add Next Riddle?

Update code and tests for the next riddle:

#### Code

- copy `/lib/next` to `/lib/<day>` 
- rename the class name in `main.rb` to `class Riddle<day>`

#### Tests

- copy `/test/test_riddle_next.rb` then 
- rename it to `/test/test_riddle<day>.rb` and 
- adjust the class name `TestRiddleNext` to `TestRiddle<day>`.

# Run the Code

`bundle exec rake test` or `ruby main.rb` to run the tests.

Run a single test:  
`ruby -w -I"lib:test" test/test_riddle06.rb --name test_calculate_race_result_sample_solution`.

A git pre-commit hook should be used to run rubocop and the tests before every commit.

## Riddles

| Day    | Riddle                                                                 | Solution |
| ------ | ---------------------------------------------------------------------- | -------- |
| Day 1  | [Trebuchet?!](https://adventofcode.com/2023/day/1)                     | ⭐️⭐️       |
| Day 2  | [Cube Conundrum](https://adventofcode.com/2023/day/2)                  | ⭐️⭐️       |
| Day 3  | [Gear Ratios](https://adventofcode.com/2023/day/3)                     | ⭐️⭐️       |
| Day 4  | [Scratchcards](https://adventofcode.com/2023/day/4)                    | ⭐️⭐️       |
| Day 5  | [If You Give A Seed A Fertilizer](https://adventofcode.com/2023/day/5) | ⭐️        |
| Day 6  | [Wait For It](https://adventofcode.com/2023/day/6)                     | ⭐️⭐️       |
| Day 7  | [Camel Cards](https://adventofcode.com/2023/day/7)                     | ⭐️⭐️       |
| Day 8  | [Haunted Wasteland](https://adventofcode.com/2023/day/8)               | ⭐️⭐️       |
| Day 9  | [Mirage Maintenance](https://adventofcode.com/2023/day/9)              | ⭐️⭐️       |
| Day 10 | [Pipe Maze](https://adventofcode.com/2023/day/10)                      | ⭐️        |
| Day 11 | [Cosmic Expansion](https://adventofcode.com/2023/day/11)               | ⭐️⭐️       |
| Day 12 | [tba](https://adventofcode.com/2023/day/12)                            |          |

