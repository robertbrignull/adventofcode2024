module Days
  class Day2 < Day
    def number
      2
    end

    def part1
      reports.filter(&:safe?).length
    end

    def part2
    end

    private

    def reports
      input.split("\n").map { |l| Report.new(l) }
    end

    class Report
      def initialize(line)
        @levels = line.split(" ").map(&:to_i)
      end

      def safe?
        increasing? || decreasing?
      end

      def increasing?
        for i in 0...@levels.length - 1
          d = @levels[i + 1] - @levels[i]
          return false if d < 1 || d > 3
        end
        true
      end

      def decreasing?
        for i in 0...@levels.length - 1
          d = @levels[i + 1] - @levels[i]
          return false if d > -1 || d < -3
        end
        true
      end
    end
  end
end
