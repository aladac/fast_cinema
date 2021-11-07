# frozen_string_literal: true

module Schemas
  class Errors
    def initialize(instance, status)
      @status = status
      @errors = instance.errors
    end

    def payload
      {
        errors: @errors.full_messages,
        status: @status
      }
    end

    def options_for_render
      {
        json: payload, status: @status
      }
    end

    def self.show
      {
        type: :object, properties: {
          errors: { type: :array, items: { type: :string } },
          status: { type: :string }
        }
      }
    end
  end
end
