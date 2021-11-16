# frozen_string_literal: true

describe(ApiKey, type: :model) do
  subject(:api_key) { build(:api_key) }

  let(:api_key_without_value) { build(:api_key, value: nil) }

  describe 'Callbacks' do
    describe '#generate_value' do
      it 'assigns a random api-key value when value blank' do
        expect { api_key_without_value.generate_value }.to(change(api_key_without_value, :value))
      end

      it 'does not assign a value when value present' do
        expect { api_key.generate_value }.not_to(change(api_key, :value))
      end
    end
  end
end
