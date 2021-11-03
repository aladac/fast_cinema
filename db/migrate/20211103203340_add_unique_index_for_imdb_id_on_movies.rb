# frozen_string_literal: true

class AddUniqueIndexForImdbIdOnMovies < ActiveRecord::Migration[6.1]
  def change
    add_index(:movies, :imdb_id, unique: true)
  end
end
