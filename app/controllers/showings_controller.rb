# frozen_string_literal: true

class ShowingsController < ApplicationController
  before_action :set_showing, only: %i[show update destroy]

  def index
    @showings = Showing.all

    render(json: @showings)
  end

  def show
    render(json: @showing)
  end

  def create
    @showing = Showing.new(showing_params)

    if @showing.save
      render(json: @showing, status: :created, location: @showing)
    else
      render_unprocessable!
    end
  end

  def update
    if @showing.update(showing_params)
      render(json: @showing)
    else
      render_unprocessable!
    end
  end

  def destroy
    @showing.destroy
  end

  private

  def set_showing
    @showing = Showing.find(params[:id])
  end

  def showing_params
    params.require(:showing).permit(:movie_id, :price_id, :start, :finish)
  end

  def render_unprocessable!
    render(**Schemas::Errors.new(@showing, :unprocessable_entity).options_for_render)
  end
end
