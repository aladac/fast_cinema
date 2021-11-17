# frozen_string_literal: true

module Schemas
  class Showtimes < Model
    def reference
      {
        '$ref': '#/definitions/Showtime'
      }
    end

    def show
      {
        type: :object, properties: {
          id: { type: :integer },
          title: { type: :string },
          price_value: { type: :string },
          rated: { type: :string },
          start: { type: :string },
          runtime: { type: :string }
        }
      }
    end
  end
end
