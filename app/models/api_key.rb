# frozen_string_literal: true

class ApiKey < ApplicationRecord
  before_save :generate_value

  def generate_value
    self.value ||= SecureRandom.hex(20)
  end
end
