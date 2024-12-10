module Days
  class Day1 < Day
    def part1
      ls = left_numbers.sort
      rs = right_numbers.sort

      raise "Lengths don't match" if ls.length != rs.length

      d = 0
      for i in 0...ls.length
        d += (ls[i] - rs[i]).abs
      end

      d
    end

    def part2
      t = 0
      for l in left_numbers
        t += l * right_numbers.filter { |r| r == l }.length
      end
      t
    end

    private

    def left_numbers
      @left_numbers ||= input.split("\n").map { |l| l.split(" ").first.to_i }
    end

    def right_numbers
      @right_numbers ||= input.split("\n").map { |l| l.split(" ").second.to_i }
    end
  end
end
