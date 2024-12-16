module Days
  class Day6 < Day
    def part1
      guard = find_guard(map)
      visited_locations = Set.new([ guard.take(2) ])

      loop do
        guard = move_guard(guard)
        break unless on_map?(guard[0], guard[1])
        visited_locations << guard.take(2)
      end

      visited_locations.size
    end

    def part2
      guard = find_guard(map)

      visited_locations = Set.new([ guard.take(2) ])
      guard_locations = Set.new([ guard ])
      loop_locations = Set.new

      loop do
        extra_obstruction = move_direction(*guard)
        if on_map?(*extra_obstruction) &&
            !visited_locations.include?(extra_obstruction) &&
            forms_loop?(guard, guard_locations.clone, extra_obstruction)
          loop_locations << extra_obstruction
        end

        guard = move_guard(guard)
        break unless on_map?(guard[0], guard[1])
        visited_locations << guard.take(2)
        guard_locations << guard
      end

      loop_locations.size
    end

    private

    def map
      @map ||= input.split("\n")
    end

    def width
      @width ||= map.first.length
    end

    def height
      @height ||= map.length
    end

    def find_guard(map)
      map.each_with_index do |row, y|
        row.each_char.with_index do |char, x|
          return [ x, y, char ] if [ ">", "<", "^", "V" ].include? char
        end
      end

      raise "No guard found"
    end

    def on_map?(x, y)
      x >= 0 && x < width && y >= 0 && y < height
    end

    def move_direction(x, y, direction)
      case direction
      when ">"
        [ x + 1, y ]
      when "<"
        [ x - 1, y ]
      when "^"
        [ x, y - 1 ]
      when "V"
        [ x, y + 1 ]
      else
        raise "Invalid direction: #{direction}"
      end
    end

    def turn_right(direction)
      case direction
      when ">"
        "V"
      when "V"
        "<"
      when "<"
        "^"
      when "^"
        ">"
      else
        raise "Invalid direction: #{direction}"
      end
    end

    def move_guard(guard, extra_obstruction = nil)
      x, y, direction = guard

      x2, y2 = move_direction(x, y, direction)

      if on_map?(x2, y2) && (map[y2][x2] == "#" || [ x2, y2 ] == extra_obstruction)
        [ x, y, turn_right(direction) ]
      else
        [ x2, y2, direction ]
      end
    end

    def forms_loop?(guard, guard_locations, extra_obstruction)
      loop do
        guard = move_guard(guard, extra_obstruction)
        return false if !on_map?(guard[0], guard[1])
        return true if guard_locations.include?(guard)
        guard_locations << guard
      end
    end
  end
end
