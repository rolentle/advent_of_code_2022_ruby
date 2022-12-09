# typed: strict

module Advent2022
  class RopeBridge
    extend T::Sig

    class Coordinates < T::Struct
      prop :x, Integer
      prop :y, Integer
    end

    class Direction < T::Enum
      extend T::Sig

      enums do
        Up = new('U')
        Down = new('D')
        Left = new('L')
        Right = new('R')
        Stop = new('S')
      end
    end

    class Motion < T::Struct
      prop :direction, Direction
      prop :step_count, Integer
    end

    sig { params(heads: Coordinates, tails: Coordinates).returns(Coordinates) }
    def self.catch_up(heads:, tails:)
      serialize_tails = tails.serialize

      if tails_on_left(heads: heads, tails: tails)
        serialize_tails = serialize_tails.merge('x' => tails.x + 1)
      elsif tails_on_right(heads: heads, tails: tails)
        serialize_tails = serialize_tails.merge('x' => tails.x - 1)
      elsif tails_on_top(heads: heads, tails: tails)
        serialize_tails = serialize_tails.merge('y' => tails.y - 1)
      elsif tails_on_bottom(heads: heads, tails: tails)
        serialize_tails = serialize_tails.merge('y' => tails.y + 1)
      end

      Coordinates.from_hash(serialize_tails)
    end

    sig { params(heads: Coordinates, tails: Coordinates).returns(T::Boolean) }
    def self.tail_is_touching(heads:, tails:)
      (-1..1).to_a.product((-1..1).to_a).any? do |(x_diff, y_diff)|
        ((heads.x + x_diff) == tails.x) && ((heads.y + y_diff) == tails.y)
      end
    end

    sig { params(heads: Coordinates, tails: Coordinates, motion: Motion).returns(T::Array[T::Array[Coordinates]]) }
    def self.move(heads:, tails:, motion:)
      steps = Array.new(motion.step_count, 1)

      case motion.direction
      when Direction::Up
        steps.each_with_object([[heads, tails]]) do |step, events|
          old_head, old_tail = events.last
          new_head = Coordinates.from_hash(old_head.serialize.merge('y' => old_head.y + step))
          new_tail = if tail_is_touching(heads: new_head, tails: old_tail)
                       old_tail
                     else
                       Coordinates.from_hash(new_head.serialize.merge('y' => new_head.y - 1))
                     end

          events << [new_head, new_tail]
        end
      when Direction::Down
        steps.each_with_object([[heads, tails]]) do |step, events|
          old_head, old_tail = events.last
          new_head = Coordinates.from_hash(old_head.serialize.merge('y' => old_head.y - step))
          new_tail = if tail_is_touching(heads: new_head, tails: old_tail)
                       old_tail
                     else
                       Coordinates.from_hash(new_head.serialize.merge('y' => new_head.y + 1))
                     end

          events << [new_head, new_tail]
        end
      when Direction::Left
        steps.each_with_object([[heads, tails]]) do |step, events|
          old_head, old_tail = events.last
          new_head = Coordinates.from_hash(old_head.serialize.merge('x' => old_head.x - step))
          new_tail = if tail_is_touching(heads: new_head, tails: old_tail)
                       old_tail
                     else
                       Coordinates.from_hash(new_head.serialize.merge('x' => new_head.x + 1))
                     end
          # puts "step #{sc += step}"
          # puts "head #{new_head.serialize}"
          # puts "tail #{new_tail.serialize}"
          # grid = Array.new(5) { |_| Array.new(6, '.') }
          # grid[new_tail.y][new_tail.x] = 'T'
          # grid[new_head.y][new_head.x] = 'H'
          # puts grid.reverse.map(&:join).join("\n")
          # puts "\n"

          events << [new_head, new_tail]
        end
      when Direction::Right
        steps.each_with_object([[heads, tails]]) do |step, events|
          old_head, old_tail = events.last
          new_head = Coordinates.from_hash(old_head.serialize.merge('x' => old_head.x + step))
          new_tail = if tail_is_touching(heads: new_head, tails: old_tail)
                       old_tail
                     else
                       Coordinates.from_hash(new_head.serialize.merge('x' => new_head.x - 1))
                     end

          events << [new_head, new_tail]
        end
      when Direction::Stop
        [[heads, tails]]
      end
    end

    sig { params(motions_input: String).returns(Integer) }
    def self.solution(motions_input)
      motions = motions_input.split("\n").map do |motion_input|
        direction_input, step_count = motion_input.split(' ')
        direction = Direction.deserialize(direction_input)
        if step_count.to_i.zero?
          direction = Direction::Stop
        end
        Motion.new(direction: direction, step_count: step_count.to_i)
      end
      head_coords = Coordinates.new(x: 0, y: 0)
      tails_coords = Coordinates.new(x: 0, y: 0)

      initial_events = [[[head_coords, tails_coords]]]

      new_events = motions.each_with_object(initial_events) do |motion, events|
        prev_event = events.last.last
        input_heads = prev_event.first
        input_tails = prev_event.last
        events << move(heads: input_heads, tails: input_tails, motion: motion)
      end
      new_events.flat_map do |motion_events|
        motion_events.map(&:last)
      end.map(&:serialize).uniq.count
    end
  end
end
