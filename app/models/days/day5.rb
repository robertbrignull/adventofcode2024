module Days
  class Day5 < Day
    def part1
      valid_updates = updates.filter do |ps|
        rules.all? { |r| r.test(ps) }
      end

      valid_updates.map { |ps| get_middle_page(ps) }.sum
    end

    def part2
      invalid_updates = updates.filter do |ps|
        !rules.all? { |r| r.test(ps) }
      end

      invalid_updates.map { |ps| get_middle_page(fix_pages(ps)) }.sum
    end

    private

    Rule = Struct.new(:a, :b) do
      def test(pages)
        i = pages.find_index(a)
        return true if i.nil?

        j = pages.find_index(b)
        j.nil? || j > i
      end
    end

    def rules
      @rules ||= input.split("\n").filter { |l| l.include?("|") }.map do |l|
        Rule.new(l.split("|")[0].to_i, l.split("|")[1].to_i)
      end
    end

    def updates
      @updates ||= input.split("\n").filter { |l| l.include?(",") }.map do |l|
        l.split(",").map(&:to_i)
      end
    end

    def get_middle_page(pages)
      raise "No middle page" if pages.length % 2 == 0
      pages[(pages.length - 1) / 2]
    end

    def fix_pages(pages)
      loop do
        pages, changed = apply_all_rules(pages)
        break unless changed
      end
      pages
    end

    def apply_all_rules(pages)
      changed = false
      new_pages = pages.dup
      rules.each do |r|
        a = new_pages.find_index(r.a)
        b = new_pages.find_index(r.b)
        if a && b && a > b
          new_pages[a], new_pages[b] = new_pages[b], new_pages[a]
          changed = true
        end
      end
      [ new_pages, changed ]
    end
  end
end
