# frozen_string_literal: true

class Showing < ApplicationRecord
  SCHEMA_CLASS = Schemas::Showings

  belongs_to :movie
  belongs_to :price

  validates :start, presence: true

  validate do
    if overlaps?
      message = I18n.t('models.showing.another_movie_is_playing')
      errors.add(:base, message)
    end
  end

  before_validation :assign_finish

  scope :showtime, lambda { |start = nil, finish = nil|
    start  ||= Time.current.at_beginning_of_week
    finish ||= start + 1.week
    joins(:movie).joins(:price)
                 .select(
                   'showings.id', 'movies.title', 'prices.value as price_value',
                   'movies.rated', 'showings.start', 'movies.runtime'
                 )
                 .where('start >= ? and finish <= ?', start, finish)
  }

  private

  def assign_finish
    return if start.blank?

    self.finish ||= start + movie.runtime_seconds
  end

  def overlaps?
    return if start.blank?

    overlap_query.first['count'].positive?
  end

  def overlap_query
    sql = <<~SQL.squish
      SELECT count(id) from showings
      where
        (start::timestamp, finish::timestamp) OVERLAPS
        ('#{start}'::timestamp, '#{finish}'::timestamp)
    SQL

    sql << "AND id <> #{id}" if id.present?

    Showing.connection.execute(sql)
  end
end
