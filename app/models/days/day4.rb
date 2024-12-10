module Days
  class Day4 < Day
    def part1
      t = 0
      for y in 0...height
        for x in 0...width
          if puzzle[y][x] == "X"
            t += check_cell(x, y)
          end
        end
      end
      t
    end

    def part2
    end

    private

    def puzzle
      @puzzle ||= input.split("\n")
    end

    def width
      @width ||= puzzle[0].length
    end

    def height
      @height ||= puzzle.length
    end

    def check_cell(x, y)
      check_line(x, y, 1, 0) +
        check_line(x, y, 1, 1) +
        check_line(x, y, 0, 1) +
        check_line(x, y, -1, 1) +
        check_line(x, y, -1, 0) +
        check_line(x, y, -1, -1) +
        check_line(x, y, 0, -1) +
        check_line(x, y, 1, -1)
    end

    def check_line(x, y, dx, dy)
      x >= 0 && x < width &&
        y >= 0 && y < height &&
        x + dx * 3 >= 0 && x + dx * 3 < width &&
        y + dy * 3 >= 0 && y + dy * 3 < height &&
        puzzle[y][x] == "X" &&
        puzzle[y + dy][x + dx] == "M" &&
        puzzle[y + dy * 2][x + dx * 2] == "A" &&
        puzzle[y + dy * 3][x + dx * 3] == "S" &&
        1 || 0
    end
  end
end
