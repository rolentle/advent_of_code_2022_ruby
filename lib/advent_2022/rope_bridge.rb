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

    sig { params(parent: Coordinates, child: Coordinates).returns(Coordinates) }
    def self.move_child(parent:, child:)
      if tail_is_touching(heads: parent, tails: child)
        child
      else
        Coordinates.from_hash(parent.serialize.merge('y' => parent.y - 1))
      end
    end

    sig { params(rope: T::Array[Coordinates], motion: Motion).returns(T::Array[T::Array[Coordinates]]) }
    def self.new_move(rope:, motion:)
      steps = Array.new(motion.step_count, 1)

      sc = 0
      case motion.direction
      when Direction::Up
        steps.each_with_object([rope]) do |step, events|
          last_rope = events.last.dup
          old_head = last_rope.shift
          new_head = Coordinates.from_hash(old_head.serialize.merge('y' => old_head.y + step))

          new_rope = last_rope.each_with_object([new_head]) do |child, temp_rope|
            parent = temp_rope.last

            new_child = if tail_is_touching(heads: parent, tails: child)
                          child
                        elsif (parent.x == child.x + 2) && (parent.y == child.y)
                          Coordinates.from_hash(parent.serialize.merge('x' => parent.x - 1))
                        elsif (parent.x == child.x - 2) && (parent.y == child.y)
                          Coordinates.from_hash(parent.serialize.merge('x' => parent.x + 1))
                        elsif (parent.x == child.x) && (parent.y == child.y + 2)
                          Coordinates.from_hash(parent.serialize.merge('y' => parent.y - 1))
                        elsif (parent.x == child.x) && (parent.y == child.y - 2)
                          Coordinates.from_hash(parent.serialize.merge('y' => parent.y + 1))
                        elsif (parent.x < child.x) && (parent.y > child.y) # up and to the left
                          Coordinates.from_hash({ 'x' => child.x - 1, 'y' => child.y + 1 })
                        elsif (parent.x > child.x) && (parent.y > child.y) # up and to the right
                          Coordinates.from_hash({ 'x' => child.x + 1, 'y' => child.y + 1 })
                        elsif (parent.x < child.x) && (parent.y < child.y) # down and to the left
                          Coordinates.from_hash({ 'x' => child.x - 1, 'y' => child.y - 1 })
                        elsif (parent.x > child.x) && (parent.y < child.y) # down and to the right
                          Coordinates.from_hash({ 'x' => child.x + 1, 'y' => child.y - 1 })
                        else
                          raise "error"
                        end
            temp_rope << new_child
          end
          events << new_rope
        end
      when Direction::Down
        steps.each_with_object([rope]) do |step, events|
          last_rope = events.last.dup
          old_head = last_rope.shift
          new_head = Coordinates.from_hash(old_head.serialize.merge('y' => old_head.y - step))

          new_rope = last_rope.each_with_object([new_head]) do |child, temp_rope|
            parent = temp_rope.last

            new_child = if tail_is_touching(heads: parent, tails: child)
                          child
                        elsif (parent.x == child.x + 2) && (parent.y == child.y)
                          Coordinates.from_hash(parent.serialize.merge('x' => parent.x - 1))
                        elsif (parent.x == child.x - 2) && (parent.y == child.y)
                          Coordinates.from_hash(parent.serialize.merge('x' => parent.x + 1))
                        elsif (parent.x == child.x) && (parent.y == child.y + 2)
                          Coordinates.from_hash(parent.serialize.merge('y' => parent.y - 1))
                        elsif (parent.x == child.x) && (parent.y == child.y - 2)
                          Coordinates.from_hash(parent.serialize.merge('y' => parent.y + 1))
                        elsif (parent.x < child.x) && (parent.y > child.y) # up and to the left
                          Coordinates.from_hash({ 'x' => child.x - 1, 'y' => child.y + 1 })
                        elsif (parent.x > child.x) && (parent.y > child.y) # up and to the right
                          Coordinates.from_hash({ 'x' => child.x + 1, 'y' => child.y + 1 })
                        elsif (parent.x < child.x) && (parent.y < child.y) # down and to the left
                          Coordinates.from_hash({ 'x' => child.x - 1, 'y' => child.y - 1 })
                        elsif (parent.x > child.x) && (parent.y < child.y) # down and to the right
                          Coordinates.from_hash({ 'x' => child.x + 1, 'y' => child.y - 1 })
                        else
                          raise "error"
                        end
            temp_rope << new_child
          end
          events << new_rope
        end
      when Direction::Left
        steps.each_with_object([rope]) do |step, events|
          last_rope = events.last.dup
          old_head = last_rope.shift
          new_head = Coordinates.from_hash(old_head.serialize.merge('x' => old_head.x - step))

          new_rope = last_rope.each_with_object([new_head]) do |child, temp_rope|
            parent = temp_rope.last

            new_child = if tail_is_touching(heads: parent, tails: child)
                          child
                        elsif (parent.x == child.x + 2) && (parent.y == child.y)
                          Coordinates.from_hash(parent.serialize.merge('x' => parent.x - 1))
                        elsif (parent.x == child.x - 2) && (parent.y == child.y)
                          Coordinates.from_hash(parent.serialize.merge('x' => parent.x + 1))
                        elsif (parent.x == child.x) && (parent.y == child.y + 2)
                          Coordinates.from_hash(parent.serialize.merge('y' => parent.y - 1))
                        elsif (parent.x == child.x) && (parent.y == child.y - 2)
                          Coordinates.from_hash(parent.serialize.merge('y' => parent.y + 1))
                        elsif (parent.x < child.x) && (parent.y > child.y) # up and to the left
                          Coordinates.from_hash({ 'x' => child.x - 1, 'y' => child.y + 1 })
                        elsif (parent.x > child.x) && (parent.y > child.y) # up and to the right
                          Coordinates.from_hash({ 'x' => child.x + 1, 'y' => child.y + 1 })
                        elsif (parent.x < child.x) && (parent.y < child.y) # down and to the left
                          Coordinates.from_hash({ 'x' => child.x - 1, 'y' => child.y - 1 })
                        elsif (parent.x > child.x) && (parent.y < child.y) # down and to the right
                          Coordinates.from_hash({ 'x' => child.x + 1, 'y' => child.y - 1 })
                        else
                          raise "error"
                        end
            temp_rope << new_child
          end
          events << new_rope
        end
      when Direction::Right
        steps.each_with_object([rope]) do |step, events|
          last_rope = events.last.dup
          old_head = last_rope.shift
          new_head = Coordinates.from_hash(old_head.serialize.merge('x' => old_head.x + step))

          new_rope = last_rope.each_with_object([new_head]) do |child, temp_rope|
            parent = temp_rope.last

            new_child = if tail_is_touching(heads: parent, tails: child)
                          child
                        elsif (parent.x == child.x + 2) && (parent.y == child.y)
                          Coordinates.from_hash(parent.serialize.merge('x' => parent.x - 1))
                        elsif (parent.x == child.x - 2) && (parent.y == child.y)
                          Coordinates.from_hash(parent.serialize.merge('x' => parent.x + 1))
                        elsif (parent.x == child.x) && (parent.y == child.y + 2)
                          Coordinates.from_hash(parent.serialize.merge('y' => parent.y - 1))
                        elsif (parent.x == child.x) && (parent.y == child.y - 2)
                          Coordinates.from_hash(parent.serialize.merge('y' => parent.y + 1))
                        elsif (parent.x < child.x) && (parent.y > child.y) # up and to the left
                          Coordinates.from_hash({ 'x' => child.x - 1, 'y' => child.y + 1 })
                        elsif (parent.x > child.x) && (parent.y > child.y) # up and to the right
                          Coordinates.from_hash({ 'x' => child.x + 1, 'y' => child.y + 1 })
                        elsif (parent.x < child.x) && (parent.y < child.y) # down and to the left
                          Coordinates.from_hash({ 'x' => child.x - 1, 'y' => child.y - 1 })
                        elsif (parent.x > child.x) && (parent.y < child.y) # down and to the right
                          Coordinates.from_hash({ 'x' => child.x + 1, 'y' => child.y - 1 })
                        else
                          raise "error"
                        end
            temp_rope << new_child
          end

          events << new_rope
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

    sig { params(motions_input: String, x: Integer, y: Integer).returns(Integer) }
    def self.solution2(motions_input:, x:, y:)
      motions = motions_input.split("\n").map do |motion_input|
        direction_input, step_count = motion_input.split(' ')
        direction = Direction.deserialize(direction_input)
        if step_count.to_i.zero?
          direction = Direction::Stop
        end
        Motion.new(direction: direction, step_count: step_count.to_i)
      end
      initial_rope = Array.new(10) { Coordinates.new(x: x, y: y) }

      initial_events = [[initial_rope]]

      new_events = motions.each_with_object(initial_events) do |motion, events|
        current_rope = events.last.last
        events << new_move(rope: current_rope, motion: motion)
      end
      new_events.flat_map do |motion_events|
        motion_events.map(&:last)
      end.map(&:serialize).uniq.count
    end
  end
end
