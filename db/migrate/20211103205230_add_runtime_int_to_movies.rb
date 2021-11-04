# frozen_string_literal: true

class AddRuntimeIntToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column(:movies, :runtime_int, :integer)
  end
end
