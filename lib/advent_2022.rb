# typed: strict
require 'sorbet-runtime'

# Main module for Advent of Code 2022
module Advent2022
  extend T::Sig

  sig { params(list_of_calories: String).returns(Integer) }
  def self.elf_with_most_calories(list_of_calories)
    elf_calories_store = calories_of_elves(list_of_calories).each_with_object({}).with_index do |(calories, store), index|
      store[index + 1] = calories
    end
    elf_calories_store.to_a.max do |(_, a_calories), (_, b_calories)|
      a_calories.sum <=> b_calories.sum
    end.first
  end

  extend T::Sig

  sig { params(list_of_calories: String).returns(T::Array[T::Array[Integer]]) }
  def self.calories_of_elves(list_of_calories)
    list_of_calories.split("\n\n").map do |individual_elf_calories|
      individual_elf_calories.split("\n").map(&:to_i)
    end
  end
end
