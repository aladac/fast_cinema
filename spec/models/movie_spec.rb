# frozen_string_literal: true

describe(Movie, type: :model) do
  describe 'Associations' do
    it { is_expected.to(have_many(:showings)) }
  end
end
