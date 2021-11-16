# frozen_string_literal: true

class Movie < ApplicationRecord
  SCHEMA_CLASS = Schemas::Movies

  has_many :showings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :imdb_id, uniqueness: true

  before_save :add_runtime_seconds

  def add_runtime_seconds
    self.runtime_seconds = runtime.split.first.to_i * 60
  end
end
