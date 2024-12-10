class DaysController < ApplicationController
  def index
    @days = days.map do |number, model|
      { title: "Day #{number}", path: day_path(number) }
    end
  end

  def show
    model = days[params[:number].to_i]
    raise ActionController::RoutingError.new("Day not Found") unless model

    @title = "Day #{params[:number]}"

    @part1_result = model.part1
    @part2_result = model.part2
  end

  private

  def days
    {}
  end
end
