module Days
  class Day9 < Day
    def part1
      m = new_disk_map.compact!

      total = 0
      m.disk.each_with_index do |v, i|
        total += i * v if v >= 0
      end
      total.to_s
    end

    def part2
    end

    private

    def new_disk_map
      DiskMap.new(input.chars.map(&:to_i))
    end

    class DiskMap
      attr_reader :disk

      def initialize(disk_map)
        @disk = []

        id = 0
        disk_map.each_with_index do |v, i|
          if i % 2 == 0
            v.times { @disk << id }
            id += 1
          else
            v.times { @disk << -1 }
          end
        end
      end

      def compact!
        i = 0
        j = @disk.length - 1
        while i < j
          if @disk[i] == -1
            @disk[i] = @disk[j]
            @disk[j] = -1
            loop do
              j -= 1
              break if @disk[j] != -1
            end
          end
          i += 1
        end

        self
      end
    end
  end
end
