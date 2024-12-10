module Days
  class Day3 < Day
    def part1
      operations.reduce(0) do |acc, op|
        acc + (op.a * op.b)
      end
    end

    def part2
    end

    private

    def operations
      input.scan(/mul\((\d{1,3}),(\d{1,3})\)/).map { |m| Mul.new(m.first.to_i, m.second.to_i) }
    end

    Mul = Struct.new(:a, :b)
  end
end
