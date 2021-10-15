require 'net/http'
require 'net/https'

class Nomics
  attr_reader :api_key

  BASE_URL = 'https://api.nomics.com/v1/'.freeze
  ResponseError = Class.new(StandardError)
  APIError = Class.new(StandardError)

  def initialize(api_key: Rails.configuration.api_key)
    raise APIError, I18n.t('services.nomics.errors.missing_key') unless api_key.present?

    @api_key = api_key
  end

  def currencies_ticker(tickers: [], filters: [], options: {})
    request_payload = NomicsPayloadBuilder.new(
      tickers: tickers,
      options: options
    ).payload

    uri = build_uri(path: 'currencies/ticker', payload: request_payload)

    NomicsFilterBuilder.new(
      response_hash: response(uri),
      filters: filters
    ).apply_filters
  end

  def convert(from:, to:)
    calculation = CoinConversion.new(
      from: from,
      to: to,
      data: currencies_ticker(tickers: [from, to], filters: %w[id price])[:response]
    )

    { response: calculation.result }
  end

  private

  def response(uri)
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https', read_timeout: 5) do |http|
      request = Net::HTTP::Get.new(uri)
      response = http.request(request)
      raise ResponseError, "#{response.code} - #{response.message}" unless response.is_a?(Net::HTTPSuccess)

      { response: JSON.parse(response.body), total_items: response['X-Pagination-Total-Items'] }
    end
  rescue StandardError => e
    Rails.logger.error("Nomics Service API error: #{e.inspect}")
    raise APIError, e
  end

  def build_uri(path:, payload: {})
    build_uri = URI.join(BASE_URL, path)
    build_uri.query = URI.encode_www_form(payload.merge(key: api_key))
    build_uri
  end
end
