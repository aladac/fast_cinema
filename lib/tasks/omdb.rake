# frozen_string_literal: true

namespace :omdb do
  desc 'Import all movies'
  task import: :environment do
    movie_ids.each do |id|
      Movie.where(imdb_id: id).first_or_create do |movie|
        movie.assign_attributes(movie_attributes(id))
      end
    end
  end

  desc 'Update existing movies'
  task update: :environment do
    Movie.all.each do |movie|
      movie.update(movie_attributes(movie.imdb_id))
    end
  end
end

def movie_ids
  YAML.load_file(Rails.root.join('config/movie_ids.yml'))
end

def movie_attributes(id)
  OmdbApi.new.get_movie(id)
end
