require "spec_helper"
require './lib/advent_2022'

describe 'day 8' do
  let(:example_input) do
    <<~HEREDOC
30373
25512
65332
33549
35390
    HEREDOC
  end

  describe '.visibility' do
    it 'return the correct input' do
      grid = Advent2022::Treetop.grid(example_input)
      expect(grid[1][1]).to eq(5)
      visibility = {
        'top' => true,
        'right' => false,
        'bottom' => false,
        'left' => true
      }

      expect(Advent2022::Treetop.visibility_directions(x_coord: 1, y_coord: 1, grid: grid)).to eq(visibility)
      visibility = {
        'top' => true,
        'right' => true,
        'bottom' => false,
        'left' => false
      }

      expect(Advent2022::Treetop.visibility_directions(x_coord: 2, y_coord: 1, grid: grid)).to eq(visibility)
      visibility = {
        'top' => false,
        'right' => false,
        'bottom' => false,
        'left' => false
      }

      expect(Advent2022::Treetop.visibility_directions(x_coord: 3, y_coord: 1, grid: grid)).to eq(visibility)
      expect(Advent2022::Treetop.total_visible_trees(grid)).to eq(21)

      fixture_input = File.read('./spec/fixtures/day_8_input.txt')
      grid = Advent2022::Treetop.grid(fixture_input)
      expect(Advent2022::Treetop.total_visible_trees(grid)).to eq(1818)
    end
  end

  describe '.scenic_score' do
    it 'return the correct input' do
      grid = Advent2022::Treetop.grid(example_input)
      expect(Advent2022::Treetop.scenic_score(x_coord: 2, y_coord: 1, grid: grid)).to eq(4)
      expect(Advent2022::Treetop.scenic_score(x_coord: 2, y_coord: 3, grid: grid)).to eq(8)
    end
  end

  describe '.max_scenic_score' do
    it 'return the correct input' do
      grid = Advent2022::Treetop.grid(example_input)
      expect(Advent2022::Treetop.max_scenic_score(grid)).to eq(8)

      fixture_input = File.read('./spec/fixtures/day_8_input.txt')
      grid = Advent2022::Treetop.grid(fixture_input)
      expect(Advent2022::Treetop.max_scenic_score(grid)).to eq(368_368)
    end
  end
end
