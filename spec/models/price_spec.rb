# frozen_string_literal: true

describe(Price, type: :model) do
  subject(:price) { create(:price) }

  describe 'Associations' do
    it { is_expected.to(have_many(:showings)) }
  end
end
