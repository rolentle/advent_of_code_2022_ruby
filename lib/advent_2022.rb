# typed: strict
require 'sorbet-runtime'
require './lib/advent_2022/paper_rock_scissors'
require './lib/advent_2022/rutsack_reorganization'
require './lib/advent_2022/camp_cleanup'
require './lib/advent_2022/supply_stacks'

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
end
