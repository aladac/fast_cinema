# frozen_string_literal: true

describe 'Showtimes', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/showtime'
      expect(response).to(have_http_status(:success))
    end
  end
end
