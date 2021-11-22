# frozen_string_literal: true

class OmdbApi
  BASE_URI = 'http://www.omdbapi.com'

  attr_accessor :uri, :api_key

  def initialize
    @uri = URI.parse(BASE_URI)
    @api_key = ENV.fetch('OMDB_API_KEY')
  end

  def get_movie(id)
    uri.query = {
      apikey: api_key,
      i: id
    }.to_query

    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response)

    parsed_response.deep_transform_keys! { |k, _v_| k.underscore.to_sym }
    parsed_response.except(:type)
  end
end
