module Days
  class Day8 < Day
    def part1
      points = Set.new

      for i in 0...antennas.length
        for j in i+1...antennas.length
          if antennas[i].frequency == antennas[j].frequency
            dx = antennas[j].x - antennas[i].x
            dy = antennas[j].y - antennas[i].y

            n1 = Point.new(x: antennas[i].x - dx, y: antennas[i].y - dy)
            n2 = Point.new(x: antennas[j].x + dx, y: antennas[j].y + dy)

            points.add(n1) if n1.on_grid?(width, height)
            points.add(n2) if n2.on_grid?(width, height)
          end
        end
      end

      points.size.to_s
    end

    def part2
      points = Set.new

      for i in 0...antennas.length
        for j in i+1...antennas.length
          if antennas[i].frequency == antennas[j].frequency
            dx = antennas[j].x - antennas[i].x
            dy = antennas[j].y - antennas[i].y

            k = 0
            loop do
              n = Point.new(x: antennas[i].x + dx * k, y: antennas[i].y + dy * k)
              break if !n.on_grid?(width, height)
              points.add(n)
              k -= 1
            end

            k = 1
            loop do
              n = Point.new(x: antennas[i].x + dx * k, y: antennas[i].y + dy * k)
              break if !n.on_grid?(width, height)
              points.add(n)
              k += 1
            end
          end
        end
      end

      points.size.to_s
    end

    private

    def grid
      @grid ||= input.split("\n").map(&:chars)
    end

    def width
      grid[0].length
    end

    def height
      grid.length
    end

    def antennas
      @antennas ||= grid.each_with_index.flat_map do |row, y|
        row.each_with_index.map do |cell, x|
          Antenna.new(x, y, cell) if cell != "."
        end
      end.compact
    end

    Point = Struct.new(:x, :y) do
      def on_grid?(width, height)
        x >= 0 && y >= 0 && x < width && y < height
      end
    end

    Antenna = Struct.new(:x, :y, :frequency)
  end
end
