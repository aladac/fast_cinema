# frozen_string_literal: true

class CreateShowings < ActiveRecord::Migration[6.1]
  def change
    create_table(:showings) do |t|
      t.references(:movie, null: false, foreign_key: true)
      t.references(:price, null: false, foreign_key: true)
      t.datetime(:start)
      t.datetime(:finish)
      t.tsrange(:time_range)

      t.timestamps
    end
  end
end
