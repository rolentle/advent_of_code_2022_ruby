# typed: strict
#
# module to determine Rutsack organization for day 2
module Advent2022
  module SupplyStacks
    extend T::Sig

    sig { params(stack_text: String).returns(T::Hash[Integer, T::Array[String]]) }
    def self.stacks(stack_text)
      raw_stacks, procedures = stack_text.split("\n\n")
      stack_section = raw_stacks.split("\n")
      unformatted_stacks = stack_section.pop
      stacks = unformatted_stacks.split(' ')

      crates = stack_section.map do |line| 
        line.chars.each_slice(4).map { |e| e }
      end.map do |line|
        line.map do |c|
          trimmed_char = c[1].strip
          trimmed_char if !trimmed_char.empty?
        end
      end.transpose.map(&:compact).map(&:reverse)
      [stacks, crates].transpose.to_h
    end
  end
end
