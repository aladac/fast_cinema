# frozen_string_literal: true

class PricesController < ApplicationController
  before_action :set_price, only: %i[show update destroy]

  def index
    @prices = Price.all

    render(json: @prices)
  end

  def show
    render(json: @price)
  end

  def create
    @price = Price.new(price_params)

    if @price.save
      render(json: @price, status: :created, location: @price)
    else
      render_unprocessable!
    end
  end

  def update
    if @price.update(price_params)
      render(json: @price)
    else
      render_unprocessable!
    end
  end

  def destroy
    @price.destroy
  end

  private

  def set_price
    @price = Price.find(params[:id])
  end

  def price_params
    params.require(:price).permit(:value, :description)
  end

  def render_unprocessable!
    render(**Schemas::Errors.new(@price, :unprocessable_entity).options_for_render)
  end
end
