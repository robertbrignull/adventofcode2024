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

    def move_guard(guard)
      x, y, direction = guard

      x2, y2 = move_direction(x, y, direction)

      if on_map?(x2, y2) && map[y2][x2] == "#"
        [ x, y, turn_right(direction) ]
      else
        [ x2, y2, direction ]
      end
    end
  end
end
