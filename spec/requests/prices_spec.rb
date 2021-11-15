# frozen_string_literal: true

describe 'Prices', type: :request do
  let(:price)            { create(:price) }
  let(:id)                  { price.id }
  let(:'X-Api-Key')         { create(:api_key).value }
  let(:unpersisted_price) { build(:price) }
  let(:invalid_price)     { build(:price, value: nil) }

  path '/prices' do
    get 'List prices' do
      tags     'Prices'
      produces 'application/json'

      response '200', 'Prices list' do
        security([{ api_key: [] }])

        schema Price.list_schema

        run_test! do |response|
          expect(response.body).to(
            eq(Price.all.to_json)
          )
        end
      end
    end

    post 'Create price' do
      let(:price) { unpersisted_price }

      tags     'Prices'
      produces 'application/json'
      consumes 'application/json'

      response '201', 'Price result' do
        security([{ api_key: [] }])

        parameter name: :price, in: :body, schema: Price.schema, required: true
        schema    Price.schema

        run_test! do |response|
          expect(Price.count).to(eq(1))
          expect(response.body).to(eq(Price.first.to_json))
        end
      end

      response '422', 'Price result' do
        let(:price) { invalid_price }

        parameter name: :price, in: :body, schema: Price.schema, required: true
        schema    Schemas::Errors.show

        run_test! do |response|
          expect(json_response(response)).to(have_key('errors'))
          expect(json_response(response)['errors']).not_to(be_empty)
        end
      end
    end
  end

  path '/prices/{id}' do
    get 'Get price' do
      tags      'Prices'
      produces  'application/json'
      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'Price result' do
        security([{ api_key: [] }])

        schema Price.schema_reference

        run_test! do |response|
          expect(response.body).to(
            eq(price.to_json)
          )
        end
      end
    end

    patch 'Update price' do
      let(:price_to_update) { create(:price) }
      let(:id) { price_to_update.id }

      let(:price) do
        build(:price)
      end

      tags 'Prices'

      produces 'application/json'
      consumes 'application/json'

      parameter name: :price, in: :body, schema: Price.schema, required: true
      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'Price result' do
        security([{ api_key: [] }])

        schema Price.schema_reference

        run_test! do |response|
          updated_price = Price.new(json_response(response))

          expect(updated_price).to(
            have_attributes(price.attributes.compact)
          )
        end
      end
    end

    delete 'Delete price' do
      security([{ api_key: [] }])

      tags 'Prices'
      parameter name: :id, in: :path, type: :integer, required: true

      response '204', 'Showing result' do
        security([{ api_key: [] }])

        run_test! do
          expect(Price.find_by(id: price.id)).to(eq(nil))
        end
      end
    end
  end
end
