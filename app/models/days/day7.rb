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
      total = 0
      equations.each do |equation|
        total += equation.value if value_possible?(equation.value, equation.operands, allow_concatenation: true)
      end
      total.to_s
    end

    private

    def equations
      input.split("\n").map do |line|
        Equation.new(line)
      end
    end

    # Can the target value be reached by adding + or * operations between the operands?
    def value_possible?(target, operands, allow_concatenation: false)
      if operands.length == 1
        operands.first == target
      else
        value_possible?(target, [ operands[0] + operands[1], *operands.drop(2) ], allow_concatenation:) ||
          value_possible?(target, [ operands[0] * operands[1], *operands.drop(2) ], allow_concatenation:) ||
          (allow_concatenation && value_possible?(target, [ (operands[0].to_s + operands[1].to_s).to_i, *operands.drop(2) ], allow_concatenation:))
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
