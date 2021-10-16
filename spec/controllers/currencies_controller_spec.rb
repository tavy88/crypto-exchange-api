RSpec.describe 'Currencies endpoint', type: :request do
  before do
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
        body: api_response,
        headers: { 'X-Pagination-Total-Items' => 3 }
      )

    allow(Rails.configuration).to receive(:api_key).and_return('test')
  end

  let(:api_endpoint) { "#{Nomics::BASE_URL}currencies/ticker" }

  describe 'request list of cryptos' do
    let(:api_response) do
      File.read('spec/fixtures/currencies_ticker_response.json')
    end

    it 'responds with 200' do
      get currencies_path(ids: 'ETH,BTC')

      expect(response).to be_successful
    end
  end

  describe 'convert one crypto to another' do
    let(:api_response) do
      File.read('spec/fixtures/2_currencies_ticker_response.json')
    end

    it 'responds with 200' do
      get convert_path(from: 'ETH', to: 'BTC')

      expect(response).to be_successful
    end
  end
end
