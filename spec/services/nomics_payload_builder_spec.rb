require 'rails_helper'

RSpec.describe NomicsPayloadBuilder do
  describe '#payload' do
    let(:tickers) { %w[ETH SOL BCH] }

    context 'when options are present' do
      let(:options) {
        {
          per_page: 1,
          page: 3
        }
      }

      let(:expected_payload) {
        {
          ids: 'ETH,SOL,BCH',
          page: 3,
          'per-page' => 1
        }
      }

      it 'builds a payload that is compliant with Nomics API' do
        expect(
          described_class.new(
            tickers: tickers,
            options: options
          ).payload
        ).to eq(expected_payload)
      end
    end

    context 'when there are no options' do
      let(:expected_payload) {
        {
          ids: 'ETH,SOL,BCH',
          page: 1,
          'per-page' => 100
        }
      }

      let(:options) { {} }

      it 'builds a payload that is compliant with Nomics API' do
        expect(
          described_class.new(
            tickers: tickers,
            options: options
          ).payload
        ).to eq(expected_payload)
      end
    end
  end
end
