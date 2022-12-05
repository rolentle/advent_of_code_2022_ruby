# typed: strict
#
# module to determine Rutsack organization for day 2
module Advent2022
  module SupplyStacks
    extend T::Sig

    sig { params(stack_text: String) .returns( T::Hash[Integer, T::Array[String]]) }
    def self.run_procedures(stack_text)
      stacks, procedures = stacks_and_procedures(stack_text)

      procedures.each_with_object(stacks) do |procedure, stacks_obj|
        stack_count, original_stack, new_stack = procedure
        stacks_obj[new_stack].push(*stacks_obj[original_stack].pop(stack_count).reverse)
      end
    end

    sig { params(stack_text: String) .returns( [ T::Hash[Integer, T::Array[String]], T::Array[T::Array[Integer]] ]) }
    def self.stacks_and_procedures(stack_text)
      raw_stacks, raw_procedures = stack_text.split("\n\n")
      stacks_structure = stacks(raw_stacks)

      procedures = raw_procedures.split("\n").map do |line|
        line.gsub(/move|from|to/, '').split.map(&:to_i)
      end

      [stacks_structure, procedures]
    end

    sig { params(raw_stacks: String).returns(T::Hash[Integer, T::Array[String]]) }
    def self.stacks(raw_stacks)
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

      [stacks.map(&:to_i), crates].transpose.to_h
    end
  end
end
