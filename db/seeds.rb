# frozen_string_literal: true

movies = YAML.load_file('db/seeds/movies.yml')
prices = YAML.load_file('db/seeds/prices.yml')

movies.each do |movie_attributes|
  Movie.create(movie_attributes)
end

prices.each do |price_attributes|
  Price.create(price_attributes)
end

ApiKey.create(value: 'super_secret')
