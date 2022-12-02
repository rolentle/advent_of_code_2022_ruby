# typed: strict
require 'sorbet-runtime'

# Main module for Advent of Code 2022
module Advent2022
  extend T::Sig

  class Elf < T::Struct
    prop :id, Integer
    prop :calories, T::Array[Integer]
  end

  Elves = T.type_alias { T::Array[Elf] }

  sig { params(elves: Elves).returns(Elf) }
  def self.elf_with_most_calories(elves)
    T.must(elves_order_by_calorie_count(elves).last)
  end

  sig { params(elves: Elves).returns(Elves) }
  def self.elves_order_by_calorie_count(elves)
    elves.sort do |a_elf, b_elf|
      a_elf.calories.sum <=> b_elf.calories.sum
    end
  end

  sig { params(list_of_calories: String).returns(Elves) }
  def self.elf_calories_store(list_of_calories)
    parsed_input = list_of_calories.split("\n\n").map do |individual_elf_calories|
      individual_elf_calories.split("\n").map(&:to_i)
    end

    parsed_input.map.with_index do |calories, index|
      Elf.new(id: index + 1, calories: calories)
    end
  end

  # module to determine PaperRockScissors for day 2
  module PaperRockScissors
    extend T::Sig
    # Defined choices for paper rocker scissors
    class Choice < T::Enum
      extend T::Sig
      enums do
        Paper = new
        Rock = new
        Scissors = new
      end

      sig { returns(Integer) }
      def score
        case self
        when Rock then 1
        when Paper then 2
        when Scissors then 3
        end
      end
    end

    Game = T.type_alias { T::Array[T.nilable(Choice)] }

    sig { params(list_of_games: String).returns(T::Array[Integer]) }
    def self.predicted_total_scores(list_of_games)
      games = encrypted_strategy_guide(list_of_games)
      games.map(&method(:predicted_scores)).transpose.map(&:sum)
    end

    sig { params(game: Game).returns(T::Array[Integer]) }
    def self.predicted_scores(game)
      game.map { |x| T.must(x).score }.zip(predicted_game_results_scores(game)).map(&:sum)
    end

    sig { params(game: Game).returns(T::Array[Integer]) }
    def self.predicted_game_results_scores(game)
      player_1_choice, player_2_choice = game

      case [player_1_choice, player_2_choice]
      when [Choice::Rock, Choice::Rock] then [3, 3]
      when [Choice::Rock, Choice::Paper] then [0, 6]
      when [Choice::Rock, Choice::Scissors] then [6, 0]
      when [Choice::Paper, Choice::Rock] then [6, 0]
      when [Choice::Paper, Choice::Paper] then [3, 3]
      when [Choice::Paper, Choice::Scissors] then [0, 6]
      when [Choice::Scissors, Choice::Rock] then [0, 6]
      when [Choice::Scissors, Choice::Paper] then [6, 0]
      when [Choice::Scissors, Choice::Scissors] then [3, 3]
      else T.absurd
      end
    end

    sig { params(list_of_games: String).returns(T::Array[Game]) }
    def self.encrypted_strategy_guide(list_of_games)
      list_of_games.split("\n").map do |line|
        line.split.map do |choice|
          case choice
          when 'A', 'X' then Choice::Rock
          when 'B', 'Y' then Choice::Paper
          when 'C', 'Z' then Choice::Scissors
          else raise 'Parsing Error'
          end
        end
      end
    end
  end
end
