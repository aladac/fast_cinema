# frozen_string_literal: true

describe(Showing, type: :model) do
  subject(:showing) { create(:showing) }

  describe 'Associations' do
    it { is_expected.to(belong_to(:movie)) }
    it { is_expected.to(belong_to(:price)) }
  end

  describe 'Validations' do
    before do
      showing = build(:showing)
      allow(showing).to(receive(:overlaps?).and_return(true))
      allow(described_class).to(receive(:new).and_return(showing))
    end

    describe 'overlaping showings' do
      it 'fail validation' do
        expect { showing.valid? }.to(raise_error(ActiveRecord::RecordInvalid))
      end
    end
  end
end
