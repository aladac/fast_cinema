# frozen_string_literal: true

describe(Showing, type: :model) do
  subject(:showing) { create(:showing) }

  describe 'Associations' do
    it { is_expected.to(belong_to(:movie)) }
    it { is_expected.to(belong_to(:price)) }
  end
end
