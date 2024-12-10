class DaysController < ApplicationController
  def index
    @days = days
  end

  def show
    model = days[params[:number].to_i - 1]
    raise ActionController::RoutingError.new("Day not Found") unless model

    @title = model.title
    @part1, @part1_time = time_it { model.part1 }
    @part2, @part2_time = time_it { model.part2 }
  end

  private

  def days
    [
      Days::Day1.new,
      Days::Day2.new,
      Days::Day3.new
    ]
  end

  def time_it(&block)
    start = Time.now
    result = block.call
    [ result, ((Time.now - start) * 1000).round ]
  end
end
