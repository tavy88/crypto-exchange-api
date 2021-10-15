require 'rails_helper'

RSpec.describe NomicsPayloadBuilder do
  describe '#payload' do
    let(:tickers) { %w[ETH SOL BCH] }
    let(:options) { {} }

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

      it 'builds a payload that is compliant with Nomics API' do
        expect(
          described_class.new(
            tickers: tickers,
            options: options
          ).payload
        ).to eq(expected_payload)
      end
    end

    it 'raises an Nomics::APIError if the tickers are not an array' do
      expect {
        described_class.new(
          tickers: 'wrong value',
          options: options
        ).payload
      }.to raise_error(Nomics::APIError, "Provided tickers have to be an array. I.e ['ETH', 'BCH']")
    end

    it 'raises an Nomics::APIError if the options are not a hash' do
      expect {
        described_class.new(
          tickers: tickers,
          options: 'wrong value'
        ).payload
      }.to raise_error(Nomics::APIError, 'Provided options have to be a Hash. I.e { per_page => 100, page => 1 }')
    end
  end
end
