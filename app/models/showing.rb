# frozen_string_literal: true

class Showing < ApplicationRecord
  belongs_to :movie
  belongs_to :price

  validates :start, presence: true

  validate do
    if overlaps?
      message = I18n.t('models.showing.another_movie_is_playing')
      errors.add(:start, message)
      errors.add(:finish, message)
    end
  end

  before_validation :assign_finish

  private

  def assign_finish
    self.finish ||= start + movie.runtime_seconds
  end

  def overlaps?
    overlap_query.first['count'].positive?
  end

  def overlap_query
    Showing.connection.execute(<<~SQL.squish)
      SELECT count(id) from showings
      where
        (start::timestamp, finish::timestamp) OVERLAPS
        ('#{start}'::timestamp, '#{finish}'::timestamp)
    SQL
  end
end
