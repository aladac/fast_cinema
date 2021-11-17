# frozen_string_literal: true

describe 'Showings', type: :request do
  let!(:showing)            { create(:showing) }
  let(:id)                  { showing.id }
  let(:movie)               { create(:movie) }
  let(:price)               { create(:price) }
  let(:unpersisted_showing) { build(:showing, movie: movie, price: price) }
  let(:invalid_showing)     { build(:showing, start: nil) }
  let(:'X-Api-Key')         { create(:api_key).value }

  path '/showings' do
    get 'List showings' do
      tags     'Showings'
      produces 'application/json'

      response '200', 'Showing list' do
        security([{ ApiKeyAuth: [] }])

        schema Showing.list_schema

        run_test! do |response|
          expect(response.body).to(
            eq(Showing.all.to_json)
          )
        end
      end
    end

    post 'Create showing' do
      let(:showing) { unpersisted_showing }

      tags     'Showings'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :showing, in: :body, schema: Showing.schema, required: true

      response '201', 'Showing result' do
        security([{ ApiKeyAuth: [] }])

        schema    Showing.schema

        run_test! do |response|
          expect(Showing.count).to(eq(1))
          expect(response.body).to(eq(Showing.first.to_json))
        end
      end

      response '422', 'Showing result' do
        let(:showing) { invalid_showing }

        schema    Schemas::Errors.show

        run_test! do |response|
          expect(json_response(response)).to(have_key('errors'))
          expect(json_response(response)['errors']).not_to(be_empty)
        end
      end
    end
  end

  path '/showings/{id}' do
    get 'Get showing' do
      tags      'Showings'
      produces  'application/json'
      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'Showing result' do
        security([{ ApiKeyAuth: [] }])

        schema Showing.schema_reference

        run_test! do |response|
          expect(response.body).to(
            eq(showing.to_json)
          )
        end
      end
    end

    patch 'Update showing' do
      let(:showing_to_update) { create(:showing) }
      let(:id) { showing_to_update.id }

      let(:showing) do
        build(:showing,
              movie: showing_to_update.movie,
              price: showing_to_update.price,
              start: showing_to_update.start + 1.hour)
      end

      tags 'Showings'

      produces 'application/json'
      consumes 'application/json'

      parameter name: :showing, in: :body, schema: Showing.schema, required: true
      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'Showing result' do
        security([{ ApiKeyAuth: [] }])

        schema Showing.schema_reference

        run_test! do |response|
          updated_showing = Showing.new(json_response(response))

          expect(updated_showing).to(
            have_attributes(showing.attributes.compact)
          )
        end
      end
    end

    delete 'Delete showing' do
      security([{ ApiKeyAuth: [] }])

      tags 'Showings'
      parameter name: :id, in: :path, type: :integer, required: true

      response '204', 'Showing result' do
        security([{ ApiKeyAuth: [] }])

        run_test! do
          expect(Showing.find_by(id: showing.id)).to(eq(nil))
        end
      end
    end
  end
end
