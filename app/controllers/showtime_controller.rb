# frozen_string_literal: true

class ShowtimeController < ApplicationController
  before_action :parse_time_params

  def index
    render(json: Showing.showtime(@start, @finish))
  end

  def parse_time_params
    return unless time_params_present?

    @start  = Time.zone.parse(params[:start])
    @finish = Time.zone.parse(params[:finish])

    head(:unprocessable_entity) and return if @start.blank?
  rescue StandardError
    head(:unprocessable_entity)
  end

  private

  def time_params_present?
    params[:start].present?
  end
end
