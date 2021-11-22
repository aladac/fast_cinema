# frozen_string_literal: true

describe 'Movies', type: :request do
  describe 'Authentication' do
    it 'fails when api key is incorrect' do
      get('/prices', headers: { 'X-Api-Key': 'foboar' })
      expect(response.code.to_i).to(eq(401))
    end

    it 'fails when api key is blank' do
      get('/prices')
      expect(response.code.to_i).to(eq(401))
    end

    it 'succeeds when api key is valid' do
      api_key = create(:api_key)
      get('/prices', headers: { 'X-Api-Key': api_key.value })
      expect(response.code.to_i).to(eq(200))
    end
  end
end
