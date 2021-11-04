# frozen_string_literal: true

module CommonHelpers
  def json_response(response)
    JSON.parse(response.body)
  end
end
