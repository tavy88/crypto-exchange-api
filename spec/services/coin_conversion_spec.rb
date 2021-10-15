require 'rails_helper'

RSpec.describe CoinConversion do
  let(:from) { 'BTC' }
  let(:to) { 'ETH' }
  let(:data) {
    [
      { 'id' => 'BTC', 'price' => '61202.47091998' },
      { 'id' => 'ETH', 'price' => '3839.12687847' }
    ]
  }

  let(:service) { described_class.new(from: from, to: to, data: data) }

  it 'converts BTC to ETH' do
    expect(service.result).to eq '1 BTC = 15.941768234648942 ETH'
  end

  context 'when from coin is missing' do
    let(:from) { nil }

    it 'raises an error' do
      expect { service.result }.to raise_error(Nomics::APIError, 'Please provide two valid coins.')
    end
  end

  context 'when to coin is missing' do
    let(:to) { nil }

    it 'raises an error' do
      expect { service.result }.to raise_error(Nomics::APIError, 'Please provide two valid coins.')
    end
  end
end
