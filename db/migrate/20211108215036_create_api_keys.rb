# frozen_string_literal: true

class CreateApiKeys < ActiveRecord::Migration[6.1]
  def change
    create_table(:api_keys) do |t|
      t.string(:value)
      t.string(:name)

      t.timestamps
    end
  end
end
