class DaysController < ApplicationController
  def index
    @days = days
  end

  def show
    model = days[params[:number].to_i - 1]
    raise ActionController::RoutingError.new("Day not Found") unless model

    @title = model.title
    @part1 = model.part1
    @part2 = model.part2
  end

  private

  def days
    [
      Days::Day1.new
    ]
  end
end
