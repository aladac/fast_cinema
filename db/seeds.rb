# frozen_string_literal: true

movies = YAML.load_file('db/seeds/movies.yml')

movies.each do |movie_attributes|
  Movie.create(movie_attributes)
end
