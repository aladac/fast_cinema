# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie

  validates :source, uniqueness: { scope: :movie }
  validates :rating, inclusion: { in: (1..5) }

  def already_rated?
    return false if errors.blank?
    return true if persisted?

    source_error.try(:type) == :taken or false
  end

  private

  def source_error
    errors.select { |e| e.attribute == :source }.first
  end
end
