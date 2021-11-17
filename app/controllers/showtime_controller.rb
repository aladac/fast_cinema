# frozen_string_literal: true

class ShowtimeController < ApplicationController
  before_action :parse_time_params

  def index
    render(json: Showing.showtime(@start, @finish))
  end

  def parse_time_params
    @start  = Time.zone.parse(params[:start])  if params[:start].present?
    @finish = Time.zone.parse(params[:finish]) if params[:finish].present?
  rescue StandardError
    head(:unprocessable_entity)
  end
end
