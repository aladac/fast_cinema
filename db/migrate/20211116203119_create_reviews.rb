# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table(:reviews) do |t|
      t.integer(:rating)
      t.string(:source)
      t.references(:movie, null: false, foreign_key: true)

      t.timestamps
    end

    add_index(:reviews, %i[source movie_id], unique: true)
  end
end
