class Day
  def number; raise NotImplementedError; end
  def part1; raise NotImplementedError; end
  def part2; raise NotImplementedError; end

  def title
    "Day #{number}"
  end

  def path
    Rails.application.routes.url_helpers.day_path(number)
  end

  def input
    @input ||= File.read("app/models/days/input/day#{number}.txt")
  end
end
