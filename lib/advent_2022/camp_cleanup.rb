# typed: strict

module Advent2022
  module CampCleanup
    extend T::Sig

    sig { params(list_of_sections: String).returns(T::Array[T::Array[T::Array[Integer]]]) }
    def self.one_section_for_input(list_of_sections)
      all_sections = list_of_sections.split("\n").map do |line|
        line.split(',').map do |sections|
          sections.split('-').map(&:to_i)
        end
      end

      all_sections.select do |(section1, section2)|
        all_encompassing_section(T.must(section1), T.must(section2)) || all_encompassing_section(T.must(section2), T.must(section1))
      end
    end

    sig { params(inner_section: T::Array[Integer], outer_section: T::Array[Integer]).returns(T::Boolean) }
    def self.all_encompassing_section(inner_section, outer_section)
      inner_low, inner_high = inner_section
      outer_low, outer_high = outer_section
      (T.must(outer_low) <= T.must(inner_low)) && (T.must(inner_high) <= T.must(outer_high))
    end
  end
end
