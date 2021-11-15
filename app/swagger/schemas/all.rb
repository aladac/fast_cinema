# frozen_string_literal: true

module Schemas
  class All
    SWAGGERED_CLASSES = [Movie, Showing, Price].freeze

    def self.show
      schemas = {}

      SWAGGERED_CLASSES.each do |klass|
        schemas[klass.to_s] = klass.schema
      end

      schemas
    end
  end
end
