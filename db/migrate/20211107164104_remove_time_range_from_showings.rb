# frozen_string_literal: true

class RemoveTimeRangeFromShowings < ActiveRecord::Migration[6.1]
  def change
    remove_column(:showings, :time_range, :tsrange)
  end
end
