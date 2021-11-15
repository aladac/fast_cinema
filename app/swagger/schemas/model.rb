# frozen_string_literal: true

module Schemas
  class Model
    attr_reader :model_class

    def initialize(model_class)
      @model_class = model_class
    end

    def show
      {
        type: :object, properties: properties
      }
    end

    def list
      {
        type: :array, items: reference
      }
    end

    def reference
      {
        '$ref': "#/components/schemas/#{model_class}"
      }
    end

    private

    def columns
      model_class.columns
    end

    def properties
      schema = {}

      columns.each do |column|
        next if column.name == 'id'

        schema[column.name] = { type: column_type(column) }
      end

      schema.deep_transform_keys(&:to_sym)
    end

    def column_type(column)
      case column.sql_type
      when 'bigint', 'integer'
        :integer
      when 'jsonb'
        :object
      else
        :string
      end
    end
  end
end
