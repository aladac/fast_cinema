# frozen_string_literal: true

describe(Review, type: :model) do
  subject(:review) { create(:review) }

  describe 'Validations' do
    it {
      expect(review).to(
        validate_uniqueness_of(:source).scoped_to(:movie_id)
      )
    }
  end
end
