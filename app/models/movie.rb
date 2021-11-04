# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :showings, dependent: :destroy

  validates :imdb_id, uniqueness: true

  before_save :add_runtime_second

  def add_runtime_second
    self.runtime_seconds = runtime.split.first.to_i * 60
  end
end
