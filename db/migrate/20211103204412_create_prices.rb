# frozen_string_literal: true

class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table(:prices) do |t|
      t.decimal(:value)
      t.string(:description)

      t.timestamps
    end
  end
end
