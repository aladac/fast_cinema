# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show review]
  before_action :already_rated?, only: :review
  after_action :cache_rating, only: :review

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
      head(:no_content)
    else
      render_unprocessable!
    end
  end

  private

  def source
    Base64.strict_encode64(
      "#{request.env['REMOTE_ADDR']}#{request.env['HTTP_USER_AGENT']}-#{params[:id]}"
    )
  end

  def already_rated?
    Rails.cache.fetch(source) and head(:too_many_requests)
  end

  def cache_rating
    Rails.cache.write(source, 1)
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def render_unprocessable!
    render_error(:unprocessable_entity)
  end

  def render_error(status)
    render(**Schemas::Errors.new(@review, status).options_for_render)
  end
end
