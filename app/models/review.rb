# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie

  validates :source, uniqueness: { scope: :movie_id }
  validates :rating, inclusion: { in: (1..5) }
end
