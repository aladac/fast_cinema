# frozen_string_literal: true

describe(Movie, type: :model) do
  subject(:movie) { create(:movie) }

  describe 'Associations' do
    it { is_expected.to(have_many(:showings)) }
    it { is_expected.to(validate_uniqueness_of(:imdb_id)) }
  end
end
