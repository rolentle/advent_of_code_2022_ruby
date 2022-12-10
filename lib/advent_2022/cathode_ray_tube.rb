# typed: strict

module Advent2022
  class CathodeRayTube
    extend T::Sig

    sig { params(program_input: String).returns(T::Array[Integer]) }
    def self.solution(program_input)
      program = program_from_string(program_input)
      x = 1
      program.each_with_object([x]) do |instruction, cycle_times|
        exec, arg = instruction
        case exec
        when 'noop'
          cycle_times << x
          puts "cycle #{cycle_times.length}: #{x}"
        when 'addx'
          2.times do
            cycle_times << x
            puts "cycle #{cycle_times.length}: #{x}"
          end
          x += arg.to_i
          puts "cycle #{cycle_times.length}: #{x}"
        end
      end
    end

    sig { params(program_input: String).returns(T::Array[[String, T.nilable(Integer)]]) }
    def self.program_from_string(program_input)
      program_input.split("\n").map do |line|
        line.strip.split(' ')
      end
    end
  end
end
