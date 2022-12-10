# typed: strict

module Advent2022
  class CathodeRayTube
    extend T::Sig

    sig { params(program_input: String).returns(T::Array[Integer]) }
    def self.solution(program_input)
      program = program_from_string(program_input)
      x = 1
      program.each_with_object([]) do |instruction, cycle_times|
        exec, arg = instruction
        case exec
        when 'noop'
          cycle_times << x
          puts "cycle #{cycle_times.length}: #{x}"
        when 'addx'
          # 2.times do
          #   cycle_times << x
          #   puts "cycle #{cycle_times.length}: #{x}"
          # end
          cycle_times << x
          puts "cycle #{cycle_times.length}: #{x}"
          cycle_times << x
          puts "cycle #{cycle_times.length}: #{x}"
          x += arg.to_i
          puts "cycle #{cycle_times.length}: #{x}"
        end
      end
    end
    sig { params(program_input: String).returns(String) }
    def self.solution2(program_input)
      program = program_from_string(program_input)
      x = 1
      crt_output = Array.new(6) { Array.new(40, ".") }

      # Sprite position: ###.....................................

      program.each_with_object([]) do |instruction, cycle_times|
        exec, arg = instruction
        case exec
        when 'noop'
          position = cycle_times.length
          if [x - 1, x, x + 1].include?(position % 40)
            crt_output[position / 40][position % 40] = '#'
          end
          cycle_times << x
        when 'addx'
          position = cycle_times.length
          if [x - 1, x, x + 1].include?(position % 40)
            crt_output[position / 40][position % 40] = '#'
          end
          cycle_times << x

          position = cycle_times.length
          if [x - 1, x, x + 1].include?(position % 40)
            crt_output[position / 40][position % 40] = '#'
          end
          cycle_times << x
          x += arg.to_i
        end
      end
      crt_output.map(&:join).join("\n") + "\n"
    end

    sig { params(program_input: String).returns(T::Array[[String, T.nilable(Integer)]]) }
    def self.program_from_string(program_input)
      program_input.split("\n").map do |line|
        line.strip.split(' ')
      end
    end
  end
end
