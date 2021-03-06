require 'rails_helper'

RSpec.describe Nomics do
  let(:service) {
    described_class.new(
      api_key: api_key
    )
  }

  let(:api_key) { 'test' }

  let(:api_endpoint) { "#{described_class::BASE_URL}currencies/ticker" }

  describe 'API BASE_URL' do
    it 'defines the correct API base url' do
      expect(described_class::BASE_URL).to eq('https://api.nomics.com/v1/')
    end
  end

  describe 'Service initialization' do
    context 'when the Nomics API key is present' do
      it 'does not raise an error' do
        expect { service }.not_to raise_error
      end
    end

    context 'when the Nomics API key is missing' do
      let(:api_key) { nil }

      it 'does raise an error' do
        expect { service }.to raise_error(Nomics::APIError, 'Please provide your API key.')
      end
    end

    context 'when the Nomics API key is present but empty' do
      let(:api_key) { '' }

      it 'does raise an error' do
        expect { service }.to raise_error(Nomics::APIError, 'Please provide your API key.')
      end
    end
  end

  describe '#currencies_ticker' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:unfiltered_api_response) do
      File.read('spec/fixtures/currencies_ticker_response.json')
    end

    let(:options) { {} }
    let(:tickers) { %w[ETH BTC XRP] }
    let(:expected_response) do
      {
        response: JSON.parse(unfiltered_api_response),
        total_items: '3'
      }
    end

    it 'returns a successful response for currency tickers ETH, BTC, XRP' do
      stub_request(:get, api_endpoint)
        .with(
          query: {
            'key' => 'test',
            'ids' => 'ETH,BTC,XRP',
            'per-page' => '100',
            'page' => '1',
            'convert' => 'USD'
          }
        )
        .to_return(
          status: 200,
          body: unfiltered_api_response,
          headers: { 'X-Pagination-Total-Items' => 3 }
        )

      expect(
        service.currencies_ticker(
          tickers: tickers,
          options: options
        )
      ).to eq(expected_response)
    end

    it 'raises error if the api response is not successful' do
      stub_request(:get, api_endpoint)
        .with(
          query: {
            'key' => 'test',
            'ids' => 'ETH,BTC,XRP',
            'per-page' => '100',
            'page' => '1',
            'convert' => 'USD'
          }
        )
        .to_return(
          status: 401
        )

      expect {
        service.currencies_ticker(
          tickers: tickers,
          options: options
        )
      }.to raise_exception(described_class::APIError)
    end

    it 'raises error if there is a NET::HTTP error' do
      stub_request(:get, api_endpoint)
        .with(
          query: {
            'key' => 'test',
            'ids' => 'ETH,BTC,XRP',
            'per-page' => '100',
            'page' => '1',
            'convert' => 'USD'
          }
        )
        .to_raise(Net::ReadTimeout)

      expect {
        service.currencies_ticker(
          tickers: tickers,
          options: options
        )
      }.to raise_exception(described_class::APIError)
    end

    context 'when options are present' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      let(:options) {
        {
          per_page: 1,
          page: 2
        }
      }

      let(:paginated_unfiltered_api_response) do
        File.read('spec/fixtures/currencies_ticker_response.json')
      end

      let(:expected_response) do
        {
          response: JSON.parse(paginated_unfiltered_api_response),
          total_items: '3'
        }
      end

      it 'passes them correctly' do
        stub_request(:get, api_endpoint)
          .with(
            query: {
              'key' => 'test',
              'ids' => 'ETH,BTC,XRP',
              'per-page' => '1',
              'page' => '2',
              'convert' => 'USD'
            }
          )
          .to_return(
            status: 200,
            body: paginated_unfiltered_api_response,
            headers: { 'X-Pagination-Total-Items' => 3 }
          )

        expect(
          service.currencies_ticker(
            tickers: tickers,
            options: options
          )
        ).to eq(expected_response)
      end
    end
  end

  describe '#convert' do
    let(:two_currencies_ticker_response) do
      File.read('spec/fixtures/2_currencies_ticker_response.json')
    end

    let(:expected_response) {
      {
        response: '1 ETH = 0.06343353940548098 BTC'
      }
    }

    it 'returns a conversion between two cryptos' do
      stub_request(:get, api_endpoint)
        .with(
          query: {
            'key' => 'test',
            'ids' => 'ETH,BTC',
            'per-page' => '100',
            'page' => '1',
            'convert' => 'USD'
          }
        )
        .to_return(
          status: 200,
          body: two_currencies_ticker_response,
          headers: { 'X-Pagination-Total-Items' => 2 }
        )

      expect(
        service.convert(
          from: 'ETH',
          to: 'BTC'
        )
      ).to eq(expected_response)
    end
  end
end
