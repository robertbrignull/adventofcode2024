module Days
  class Day7 < Day
    def part1
      total = 0
      equations.each do |equation|
        total += equation.value if value_possible?(equation.value, equation.operands)
      end
      total.to_s
    end

    def part2
    end

    private

    def equations
      input.split("\n").map do |line|
        Equation.new(line)
      end
    end

    # Can the target value be reached by adding + or * operations between the operands?
    def value_possible?(target, operands)
      if operands.length == 1
        operands.first == target
      else
        value_possible?(target, [ operands[0] + operands[1], *operands.drop(2) ]) ||
          value_possible?(target, [ operands[0] * operands[1], *operands.drop(2) ])
      end
    end
  end

  class Equation
    attr_reader :value, :operands

    def initialize(line)
      @value = line.split(": ").first.to_i
      @operands = line.split(": ").last.split(" ").map(&:to_i)
    end
  end
end
