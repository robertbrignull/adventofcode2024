module Days
  class Day2 < Day
    def part1
      reports.filter { |r| r.safe?(false) }.length
    end

    def part2
      reports.filter { |r| s = r.safe?(true); puts(r.to_s + "   =>   " + s.to_s); s }.length
    end

    private

    def reports
      input.split("\n").map { |l| Report.new(l) }
    end

    class Report
      def initialize(line)
        @levels = line.split(" ").map(&:to_i)
      end

      def to_s
        @levels.join(" ")
      end

      def safe?(dampen)
        puts("Checking increasing...")
        is_inc = fits_sequence?(dampen) { |d| d >= 1 && d <= 3 }
        puts(is_inc)

        puts("Checking decreasing...")
        is_dec = fits_sequence?(dampen) { |d| d <= -1 && d >= -3 }
        puts(is_dec)

        is_inc || is_dec
      end

      def fits_sequence?(dampen, &block)
        dampen_used = false
        i = -1
        while i < @levels.length - 2
          i += 1

          next if block.call(@levels[i + 1] - @levels[i])

          # Abort if either we can't dampen or we've already used it
          return false if !dampen || dampen_used

          # If we're at the end of the list and we can dampen,
          # return true because we can remove the last level
          if i == @levels.length - 2
            puts("Dampening last level")
            return true
          end

          # Try removing the second level because we know everything up to this point is ok
          if block.call(@levels[i + 2] - @levels[i])
            puts("Dampening " + i.to_s + ": " + @levels[i].to_s)
            dampen_used = true
            i += 1
            next
          end

          # Then try backtracking and removing the first level
          if i > 0 && block.call(@levels[i + 1] - @levels[i - 1])
            puts("Dampening " + i.to_s + ": " + @levels[i].to_s)
            dampen_used = true
            next
          end

          if i == 0 && @levels.length >= 3 && block.call(@levels[i + 2] - @levels[i + 1])
            puts("Dampening first: " + @levels[i].to_s)
            dampen_used = true
            next
          end

          return false
        end
        true
      end
    end
  end
end
