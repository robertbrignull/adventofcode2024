module Days
  class Day3 < Day
    def part1
      t = 0
      operations.each do |op|
        if op.is_a?(Mul)
          t += op.a * op.b
        end
      end
      t
    end

    def part2
      enabled = true
      t = 0
      operations.each do |op|
        if op.is_a?(Do)
          enabled = true
        elsif op.is_a?(Dont)
          enabled = false
        elsif enabled
          t += op.a * op.b
        end
      end
      t
    end

    private

    def operations
      input.scan(/(?:mul\((\d{1,3}),(\d{1,3})\))|(do\(\))|(don't\(\))/).map do |m|
        if m[2] == "do()"
          Do.new
        elsif m[3] == "don't()"
          Dont.new
        else
          Mul.new(m[0].to_i, m[1].to_i)
        end
      end
    end

    class Do; end
    class Dont; end
    Mul = Struct.new(:a, :b)
  end
end
