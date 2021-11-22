# frozen_string_literal: true

describe OmdbApi do
  describe 'get_movie' do
    before do
      movie = build(:movie)
      allow(Net::HTTP).to(receive(:get).and_return(movie.to_json))
      allow(ENV).to(receive(:fetch).and_return(true))
    end

    it 'returns a movie response from the api' do
      expect(described_class.new.get_movie('id')).to(be_a(Hash))
    end
  end
end
