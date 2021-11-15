# frozen_string_literal: true

class Price < ApplicationRecord
  SCHEMA_CLASS = Schemas::Prices

  has_many :showings, dependent: :nullify

  validates :value, presence: true
end
