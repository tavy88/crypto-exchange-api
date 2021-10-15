require 'rails_helper'

RSpec.describe NomicsFilterBuilder do
  describe '#apply_filters' do
    let(:filters) { %w[circulating_supply max_supply name] }

    let(:response_hash) {
      {
        response: JSON.parse(response),
        total_items: 3
      }
    }

    let(:response) {
      File.read('spec/fixtures/currencies_ticker_response.json')
    }

    let(:expected_response) {
      {
        response: [
          { 'circulating_supply' => '18844375', 'max_supply' => '21000000', 'name' => 'Bitcoin' },
          { 'circulating_supply' => '117936060', 'name' => 'Ethereum' },
          { 'circulating_supply' => '46878114887', 'max_supply' => '100000000000', 'name' => 'XRP' }
        ],
        total_items: 3
      }
    }

    it 'returns a filtered response' do
      expect(
        described_class.new(
          response_hash: response_hash,
          filters: filters
        ).apply_filters
      ).to eq(expected_response)
    end

    it 'raises an Nomics::APIError if the filters are not an array' do
      expect {
        described_class.new(
          response_hash: response_hash,
          filters: 'incorrect value'
        ).apply_filters
      }.to raise_error(Nomics::APIError, "Provided filters have to be an array. I.e ['circulating_supply', 'max_supply', 'name']")
    end
  end
end
