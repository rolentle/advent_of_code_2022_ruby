require "spec_helper"
require './lib/advent_2022'

describe 'day 10' do
  let(:example_input) do
    <<~HEREDOC
noop
addx 3
addx -5
    HEREDOC
  end
  let(:example_input2) do
    <<~HEREDOC
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop
    HEREDOC
  end

  describe '.solution' do
    it 'returns for example' do
      # expect(Advent2022::CathodeRayTube.solution(example_input)).to eq([1,1, 1, 4, 4, -1])
      cycle_times = Advent2022::CathodeRayTube.solution(example_input2)
      puts cycle_times
      cycle20 = cycle_times[19] * 20
      cycle60 = cycle_times[59] * 60
      cycle100 = cycle_times[99] * 100
      cycle140 = cycle_times[139] * 140
      cycle180 = cycle_times[179] * 180
      cycle220 = cycle_times[219] * 220
      expect(cycle20).to eq(420)
      expect(cycle60).to eq(1140)
      expect(cycle100).to eq(1800)
      expect(cycle140).to eq(2940)
      expect(cycle180).to eq(2880)
      expect(cycle220).to eq(3960)
      expect([cycle20, cycle60, cycle100,cycle140, cycle180, cycle220].sum).to eq(13_140)

      fixture_input = File.read('./spec/fixtures/day_10_input.txt')
      cycle_times = Advent2022::CathodeRayTube.solution(fixture_input)
      cycle20 = cycle_times[19] * 20
      cycle60 = cycle_times[59] * 60
      cycle100 = cycle_times[99] * 100
      cycle140 = cycle_times[139] * 140
      cycle180 = cycle_times[179] * 180
      cycle220 = cycle_times[219] * 220
      expect([cycle20, cycle60, cycle100,cycle140, cycle180, cycle220].sum).to eq(12_980)
      expect(cycle_times.count).to eq(240)
    end
  end
  describe '.solution2' do
    it 'returns for example' do
      # expect(Advent2022::CathodeRayTube.solution(example_input)).to eq([1,1, 1, 4, 4, -1])
      actual_output = Advent2022::CathodeRayTube.solution2(example_input2)
      expected_output = <<~HEREDOC
##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######.....
      HEREDOC

      expect(actual_output).to eq(expected_output)
      fixture_input = File.read('./spec/fixtures/day_10_input.txt')
      actual_output = Advent2022::CathodeRayTube.solution2(fixture_input)
      expect(actual_output).to eq(expected_output)
    end
  end
end
