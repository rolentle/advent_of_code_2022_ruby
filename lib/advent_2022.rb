# typed: strict
require 'sorbet-runtime'

# Main module for Advent of Code 2022
module Advent2022
  extend T::Sig

  class Elf < T::Struct
    prop :id, Integer
    prop :calories, T::Array[Integer]
  end

  sig { params(list_of_calories: String).returns(Elf) }
  def self.elf_with_most_calories(list_of_calories)
    elf_store = elf_calories_store(list_of_calories)
    T.must(elves_order_by_calorie_count(elf_store).last)
  end

  sig { params(elf_store: T::Array[Elf]).returns(T::Array[Elf]) }
  def self.elves_order_by_calorie_count(elf_store)
    elf_store.sort do |a_elf, b_elf|
      a_elf.calories.sum <=> b_elf.calories.sum
    end
  end

  sig { params(list_of_calories: String).returns(T::Array[Elf]) }
  def self.elf_calories_store(list_of_calories)
    parsed_input = list_of_calories.split("\n\n").map do |individual_elf_calories|
      individual_elf_calories.split("\n").map(&:to_i)
    end
    parsed_input.map.with_index do |calories, index|
      Elf.new(id: index + 1, calories: calories)
    end
  end
end
