require "spec_helper"
require './lib/advent_2022'

describe 'day 6' do
  describe '.marker' do
    it 'returns index + 1 of the beginning of the buffer' do
      expect(Advent2022::TuningTrouble.marker('mjqjpqmgbljsphdztnvjfqwrcgsmlb')).to eq(7)
      expect(Advent2022::TuningTrouble.marker('bvwbjplbgvbhsrlpgdmjqwftvncz')).to eq(5)
      expect(Advent2022::TuningTrouble.marker('nppdvjthqldpwncqszvftbrmjlhg')).to eq(6)
      expect(Advent2022::TuningTrouble.marker('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg')).to eq(10)
      expect(Advent2022::TuningTrouble.marker('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw')).to eq(11)

      fixture_input = File.read('./spec/fixtures/day_6_input.txt')
      expect(Advent2022::TuningTrouble.marker(fixture_input)).to eq(1531)
    end
  end
  
  describe '.messages' do
    it 'returns index + 1 of the beginning of the buffer' do
      expect(Advent2022::TuningTrouble.messages('mjqjpqmgbljsphdztnvjfqwrcgsmlb')).to eq(19)
      expect(Advent2022::TuningTrouble.messages('bvwbjplbgvbhsrlpgdmjqwftvncz')).to eq(23)
      expect(Advent2022::TuningTrouble.messages('nppdvjthqldpwncqszvftbrmjlhg')).to eq(23)
      expect(Advent2022::TuningTrouble.messages('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg')).to eq(29)
      expect(Advent2022::TuningTrouble.messages('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw')).to eq(26)

      fixture_input = File.read('./spec/fixtures/day_6_input.txt')
      expect(Advent2022::TuningTrouble.messages(fixture_input)).to eq(2518)
    end
  end
end
