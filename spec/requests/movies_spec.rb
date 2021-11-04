# frozen_string_literal: true

describe 'Movies', type: :request do
  subject!(:movie) { create(:movie) }

  path '/movies' do
    get 'List movies' do
      tags 'Movies'
      produces 'application/json', 'application/xml'
      response '200', 'Movie list' do
        schema type: :array, items: { '$ref': '#/components/schemas/Movie' }

        run_test! do |response|
          expect(response.body).to(
            eq(Movie.all.to_json)
          )
        end
      end
    end
  end

  path '/movies/{id}' do
    let(:id) { movie.id }

    get 'Get movie' do
      tags 'Movies'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'Movie result' do
        schema '$ref': '#/components/schemas/Movie'

        run_test! do |response|
          expect(response.body).to(
            eq(movie.to_json)
          )
        end
      end
    end
  end
end
