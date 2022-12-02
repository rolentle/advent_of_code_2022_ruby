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
      enums do
        Paper = new
        Rock = new
        Scissors = new
      end
    end

    sig { params(list_of_games: String).returns(T::Array[T::Array[T.nilable(Choice)]]) }
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
