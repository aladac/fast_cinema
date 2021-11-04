# frozen_string_literal: true

describe 'Movies', type: :request do
  path '/movies' do
    get 'List movies' do
      tags 'Movies'
      produces 'application/json', 'application/xml'
      response '200', 'Movie list' do
        schema '$ref' => '#/components/schemas/Movie'

        run_test! do |response|
          expect(response).to(be_a(Array))
        end
      end
    end
  end
end
