# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show review]

  def index
    @movies = Movie.all

    render(json: @movies)
  end

  def show
    render(json: @movie)
  end

  def review
    @review = @movie.reviews.new(rating: params[:rating], source: source)

    if @review.save
      head(:ok)
    else
      render_review_error!
    end
  end

  private

  def source
    Base64.strict_encode64(
      request.env['REMOTE_ADDR'] + request.env['HTTP_USER_AGENT']
    )
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def render_unprocessable!
    render_error(:unprocessable_entity)
  end

  def render_review_error!
    if @review.already_rated?
      render_error(:too_many_requests)
    else
      render_unprocessable!
    end
  end

  def render_error(status)
    render(**Schemas::Errors.new(@review, status).options_for_render)
  end
end
