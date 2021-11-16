# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie

  validates :source, uniqueness: { scope: :movie }
  validates :rating, inclusion: { in: (1..5) }

  def already_rated?
    return true if persisted?
    return false if errors.blank?

    errors.select { |e| e.attribute == :source }.first.type == :taken
  end
end
