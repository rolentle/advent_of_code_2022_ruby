# typed: strict
#
# module to determine Rutsack organization for day 2
module Advent2022
  module RutsackReorganization
    extend T::Sig
    SCORE_STORE = T.let((('a'..'z').to_a + ('A'..'Z').to_a).each_with_object({}).with_index do |(item_key, store), index|
      store[item_key] = index + 1
    end.freeze, T::Hash[String, T.nilable(Integer)])

    sig { params(list_of_compartments: String).returns(T.nilable(Integer)) }
    def self.total_priority_score(list_of_compartments)
      list_of_compartments.split("\n").map do |all_items|
        compartment_split(all_items)
      end.map do |compartments|
        duplicated_item(compartments)
      end.map do |duplicated_item|
        item_priority_score(duplicated_item)
      end.sum
    end

    sig { params(list_of_compartments: String).returns(T.nilable(Integer)) }
    def self.total_badge_score(list_of_compartments)
      items = list_of_compartments.split("\n").each_slice(3).map do |compartments|
        badge_item(compartments)
      end
      items.map do |duplicated_item|
        item_priority_score(T.must(duplicated_item))
      end.sum
    end

    sig { params(all_items: String).returns(T::Array[T.nilable(String)]) }
    def self.compartment_split(all_items)
      all_items_midpoint = all_items.length / 2
      first_compartment = all_items[0...all_items_midpoint]
      second_compartment = all_items[all_items_midpoint..-1]

      [first_compartment, second_compartment]
    end

    sig { params(compartments: T::Array[T.nilable(String)]).returns(String) }
    def self.duplicated_item(compartments)
      first_compartment, second_compartment = compartments
      T.must((T.must(first_compartment).split('') & T.must(second_compartment).split('')).first)
    end

    sig { params(raw_compartments: T::Array[T.nilable(String)]).returns(T.nilable(String)) }
    def self.badge_item(raw_compartments)
      compartments = raw_compartments.map { |c| T.must(c).split('') }
      first_compartment = compartments.shift
      first_compartment.intersection(*compartments).first
    end

    sig { params(item: String).returns(T.nilable(Integer)) }
    def self.item_priority_score(item)
      SCORE_STORE[item]
    end
  end
end
