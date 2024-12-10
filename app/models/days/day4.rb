module Days
  class Day4 < Day
    def part1
      t = 0
      for y in 0...height
        for x in 0...width
          t += check_xmas_cell(x, y)
        end
      end
      t
    end

    def part2
      t = 0
      for y in 1...height-1
        for x in 1...width-1
          t += check_mas_cell(x, y)
        end
      end
      t
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

    def check_xmas_cell(x, y)
      return 0 unless puzzle[y][x] == "X"
      check_xmas_line(x, y, 1, 0) +
        check_xmas_line(x, y, 1, 1) +
        check_xmas_line(x, y, 0, 1) +
        check_xmas_line(x, y, -1, 1) +
        check_xmas_line(x, y, -1, 0) +
        check_xmas_line(x, y, -1, -1) +
        check_xmas_line(x, y, 0, -1) +
        check_xmas_line(x, y, 1, -1)
    end

    def check_xmas_line(x, y, dx, dy)
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

    def check_mas_cell(x, y)
      return 0 unless puzzle[y][x] == "A"
      check_mas_x(x, y, 1, 1) +
        check_mas_x(x, y, 1, -1) +
        check_mas_x(x, y, -1, 1) +
        check_mas_x(x, y, -1, -1)
    end

    def check_mas_x(x, y, d1, d2)
      x >= 1 && x < width - 1 &&
        y >= 1 && y < height - 1 &&
        puzzle[y][x] == "A" &&
        puzzle[y + d1][x + d1] == "M" &&
        puzzle[y - d1][x - d1] == "S" &&
        puzzle[y + d2][x - d2] == "M" &&
        puzzle[y - d2][x + d2] == "S" &&
        1 || 0
    end
  end
end
