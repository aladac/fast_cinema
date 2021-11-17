# frozen_string_literal: true

module Schemas
  class All
    SWAGGERED_CLASSES = [Movie, Price, Showing].freeze

    def self.show
      schemas = {}

      SWAGGERED_CLASSES.each do |klass|
        schemas[klass.to_s] = klass.schema
      end

      schemas['Showtime'] = Schemas::Showtimes.new.show

      schemas
    end
  end
end
