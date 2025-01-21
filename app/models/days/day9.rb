module Days
  class Day9 < Day
    def part1
      m = Disk.new(unwrap_disk(read_disk_map)).compact_with_fragmentation!

      total = 0
      m.disk.each_with_index do |v, i|
        total += i * v if v >= 0
      end
      total.to_s
    end

    def part2
      m = Disk.new(unwrap_disk(read_disk_map))

      m.compact_without_fragmentation!

      total = 0
      m.disk.each_with_index do |v, i|
        total += i * v if v >= 0
      end
      total.to_s
    end

    private

    def read_disk_map
      input.chars.map(&:to_i)
    end

    def unwrap_disk(disk_map)
      disk = []
      id = 0
      disk_map.each_with_index do |v, i|
        if i % 2 == 0
          v.times { disk << id }
          id += 1
        else
          v.times { disk << -1 }
        end
      end
      disk
    end

    class Disk
      attr_reader :disk

      def initialize(disk)
        @disk = disk
      end

      def compact_with_fragmentation!
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

      def compact_without_fragmentation!
        j = @disk.length - 1
        while j > 0
          if @disk[j] == -1
            j -= 1
            next
          end

          l = 1
          while j - l >= 0 && @disk[j - l] == @disk[j]
            l += 1
          end

          i = find_space(l, j)
          if i.nil?
            j -= l
            next
          end

          for k in 0...l do
            @disk[i + k] = @disk[j - k]
            @disk[j - k] = -1
          end

          j -= l
        end

        self
      end

      def find_space(size, end_index)
        for i in 0...end_index do
          next if @disk[i] != -1

          l = 0
          while i + l < end_index && @disk[i + l] == -1
            l += 1
          end

          return i if l >= size
        end
        nil
      end
    end
  end
end
