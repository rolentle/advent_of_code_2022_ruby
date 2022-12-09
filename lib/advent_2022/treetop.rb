# typed: strict

module Advent2022
  module Treetop
    extend T::Sig
    Grid = T.type_alias(T::Array[T::Array[T.nilable(Integer)]])

    sig { params(grid_input: String).returns(Grid) }
    def self.grid(grid_input)
      grid_input.split("\n").map do |line|
        line.split('').map(&:to_i)
      end
    end

    sig { params(grid: Grid).returns(Integer) }
    def self.total_visible_trees(grid)
      x_max = grid.first.length - 1
      y_max = grid.length - 1
      all_coordinates = (0..x_max).to_a.product((0..y_max).to_a)
      all_coordinates.count do |(x_coord, y_coord)|
        x_coord.zero? ||
        (x_coord == x_max) ||
        y_coord.zero? ||
        (y_coord == y_max) ||
        visibility_directions(x_coord: x_coord, y_coord: y_coord, grid: grid).values.any?
      end
    end

    sig { params(x_coord: Integer, y_coord: Integer, grid: Grid).returns(T::Hash[String, T::Boolean]) }
    def self.visibility_directions(x_coord:, y_coord:, grid:)
      tree_height = grid[y_coord][x_coord]
      x_max = grid.first.length - 1
      y_max = grid.length - 1

      top_visibility = (0..(y_coord - 1)).to_a.all? do |top_y|
        grid[top_y][x_coord] < tree_height
      end

      right_visibility = ((x_coord + 1)..x_max).to_a.all? do |right_x|
        grid[y_coord][right_x] < tree_height
      end

      bottom_visiblity = ((y_coord + 1)..y_max).to_a.all? do |bottom_y|
        grid[bottom_y][x_coord] < tree_height
      end

      left_visibility = (0..(x_coord - 1)).to_a.all? do |right_x|
        grid[y_coord][right_x] < tree_height
      end
      {
        'top' => top_visibility,
        'right' => right_visibility,
        'bottom' => bottom_visiblity,
        'left' => left_visibility
      }
    end

    sig { params(x_coord: Integer, y_coord: Integer, grid: Grid).returns(Integer) }
    def self.scenic_score(x_coord:, y_coord:, grid:)
      tree_height = grid[y_coord][x_coord]
      x_max = grid.first.length - 1
      y_max = grid.length - 1

      top_tree_count = (0..(y_coord - 1)).to_a.reverse.reduce(0) do |count, top_y|
        current_tree_height = grid[top_y][x_coord]
        count += 1
        break count if current_tree_height >= tree_height

        count
      end

      right_tree_count = ((x_coord + 1)..x_max).to_a.reduce(0) do |count, right_x|
        current_tree_height = grid[y_coord][right_x]
        count += 1
        break count if current_tree_height >= tree_height

        count
      end

      bottom_tree_count = ((y_coord + 1)..y_max).to_a.reduce(0) do |count, bottom_y|
        current_tree_height = grid[bottom_y][x_coord]
        count += 1
        break count if current_tree_height >= tree_height

        count
      end

      left_tree_count = (0..(x_coord - 1)).to_a.reverse.reduce(0) do |count, left_x|
        current_tree_height = grid[y_coord][left_x]
        count += 1
        break count if current_tree_height >= tree_height

        count
      end

      top_tree_count * right_tree_count * bottom_tree_count * left_tree_count
    end

    sig { params(grid: Grid).returns(Integer) }
    def self.max_scenic_score(grid)
      x_max = grid.first.length - 1
      y_max = grid.length - 1
      all_coordinates = (0..x_max).to_a.product((0..y_max).to_a)
      all_coordinates.map do |(x_coord, y_coord)|
        0 if x_coord.zero? || (x_coord == x_max) || y_coord.zero? || (y_coord == y_max)
        scenic_score(x_coord: x_coord, y_coord: y_coord, grid: grid)
      end.max
    end
  end
end
