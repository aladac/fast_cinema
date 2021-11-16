# frozen_string_literal: true

describe 'Movies', type: :request do
  subject!(:movie) { create(:movie) }

  path '/movies' do
    get 'List movies' do
      tags 'Movies'
      produces 'application/json'
      response '200', 'Movie list' do
        schema Movie.list_schema

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
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'Movie result' do
        schema Movie.schema_reference

        run_test! do |response|
          expect(response.body).to(
            eq(movie.to_json)
          )
        end
      end
    end

    path '/movies/{id}/review/{rating}' do
      let(:id) { movie.id }
      let(:rating) { rand(1..4) }

      post 'Review movie' do
        tags 'Movies'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer, required: true
        parameter name: :rating, in: :path, type: :integer, required: true

        response '204', 'Rating success' do
          run_test!
        end
      end
    end
  end
end
