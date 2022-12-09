require "spec_helper"
require './lib/advent_2022'

describe 'day 9' do
  let(:example_input) do
    <<~HEREDOC
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
    HEREDOC
  end

  describe '.solution' do
    it 'return the answer' do
      expect(Advent2022::RopeBridge.solution(example_input)).to eq(13)
    end
  end

  describe '.tail_is_touching' do
    describe 'on the left' do
      it 'returns true' do
        heads = Advent2022::RopeBridge::Coordinates.new(x: 2, y: 1)
        tails = Advent2022::RopeBridge::Coordinates.new(x: 1, y: 1)

        expect(Advent2022::RopeBridge.tail_is_touching(heads: heads, tails: tails)).to be_truthy
      end
    end

    describe 'diagonal' do
      it 'returns true' do
        heads = Advent2022::RopeBridge::Coordinates.new(x: 1, y: 2)
        tails = Advent2022::RopeBridge::Coordinates.new(x: 2, y: 1)

        expect(Advent2022::RopeBridge.tail_is_touching(heads: heads, tails: tails)).to be_truthy
      end
    end

    describe 'on top' do
      it 'returns true' do
        heads = Advent2022::RopeBridge::Coordinates.new(x: 1, y: 1)
        tails = Advent2022::RopeBridge::Coordinates.new(x: 1, y: 1)

        expect(Advent2022::RopeBridge.tail_is_touching(heads: heads, tails: tails)).to be_truthy
      end
    end

    describe 'no where close' do
      it 'returns true' do
        heads = Advent2022::RopeBridge::Coordinates.new(x: 2, y: 1)
        tails = Advent2022::RopeBridge::Coordinates.new(x: 6, y: 9)

        expect(Advent2022::RopeBridge.tail_is_touching(heads: heads, tails: tails)).to be_falsey
      end
    end
  end
  describe '.move' do
    # describe 'small examples' do
    #   describe 'moves R2' do
    #     it 'returns the answer' do
    #     end
    #   end
    # end

   it 'return the answer' do
      right = Advent2022::RopeBridge::Direction::Right
      up = Advent2022::RopeBridge::Direction::Up
      left = Advent2022::RopeBridge::Direction::Left
      down = Advent2022::RopeBridge::Direction::Down

      heads = Advent2022::RopeBridge::Coordinates.new(x: 0, y: 0)
      tails = Advent2022::RopeBridge::Coordinates.new(x: 0, y: 0)
      motion = Advent2022::RopeBridge::Motion.new(direction: right, step_count: 4)
      new_heads = Advent2022::RopeBridge::Coordinates.new(x: 4, y: 0)
      new_tails = Advent2022::RopeBridge::Coordinates.new(x: 3, y: 0)
      expect(Advent2022::RopeBridge.move(heads: heads, tails: tails, motion: motion).map(&:serialize)).to eq([new_heads, new_tails].map(&:serialize))

      heads = new_heads
      tails = new_tails
      u4 = Advent2022::RopeBridge::Motion.new(direction: up, step_count: 4)
      new_heads = Advent2022::RopeBridge::Coordinates.new(x: 4, y: 4)
      new_tails = Advent2022::RopeBridge::Coordinates.new(x: 4, y: 3)
      expect(Advent2022::RopeBridge.move(heads: heads, tails: tails, motion: u4).map(&:serialize)).to eq([new_heads, new_tails].map(&:serialize))

      heads = new_heads
      tails = new_tails
      l3 = Advent2022::RopeBridge::Motion.new(direction: left, step_count: 3)
      new_heads = Advent2022::RopeBridge::Coordinates.new(x: 1, y: 4)
      new_tails = Advent2022::RopeBridge::Coordinates.new(x: 2, y: 4)
      expect(Advent2022::RopeBridge.move(heads: heads, tails: tails, motion: l3).map(&:serialize)).to eq([new_heads, new_tails].map(&:serialize))

      heads = new_heads
      tails = new_tails
      d1 = Advent2022::RopeBridge::Motion.new(direction: down, step_count: 1)
      new_heads = Advent2022::RopeBridge::Coordinates.new(x: 1, y: 3)
      new_tails = tails
      expect(Advent2022::RopeBridge.move(heads: heads, tails: tails, motion: d1).map(&:serialize)).to eq([new_heads, new_tails].map(&:serialize))

      heads = new_heads
      tails = new_tails
      d1 = Advent2022::RopeBridge::Motion.new(direction: right, step_count: 4)
      new_heads = Advent2022::RopeBridge::Coordinates.new(x: 5, y: 3)
      new_tails = Advent2022::RopeBridge::Coordinates.new(x: 4, y: 3)
      expect(Advent2022::RopeBridge.move(heads: heads, tails: tails, motion: d1).map(&:serialize)).to eq([new_heads, new_tails].map(&:serialize))

      heads = new_heads
      tails = new_tails
      d1 = Advent2022::RopeBridge::Motion.new(direction: down, step_count: 1)
      new_heads = Advent2022::RopeBridge::Coordinates.new(x: 5, y: 2)

      new_tails = tails
      expect(Advent2022::RopeBridge.move(heads: heads, tails: tails, motion: d1).map(&:serialize)).to eq([new_heads, new_tails].map(&:serialize))

      heads = new_heads
      tails = new_tails
      l5 = Advent2022::RopeBridge::Motion.new(direction: left, step_count: 5)
      new_heads = Advent2022::RopeBridge::Coordinates.new(x: 0, y: 2)
      new_tails = Advent2022::RopeBridge::Coordinates.new(x: 1, y: 2)
      expect(Advent2022::RopeBridge.move(heads: heads, tails: tails, motion: l5).map(&:serialize)).to eq([new_heads, new_tails].map(&:serialize))

      heads = new_heads
      tails = new_tails
      r2 = Advent2022::RopeBridge::Motion.new(direction: right, step_count: 2)
      new_heads = Advent2022::RopeBridge::Coordinates.new(x: 2, y: 2)
      new_tails = Advent2022::RopeBridge::Coordinates.new(x: 1, y: 2)
      expect(Advent2022::RopeBridge.move(heads: heads, tails: tails, motion: r2).map(&:serialize)).to eq([new_heads, new_tails].map(&:serialize))
    end
  end
end
