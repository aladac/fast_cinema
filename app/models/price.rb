# frozen_string_literal: true

class Price < ApplicationRecord
  has_many :showings, dependent: :nullify
end
