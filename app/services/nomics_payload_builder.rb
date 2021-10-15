class NomicsPayloadBuilder
  attr_reader :tickers, :options

  PER_PAGE = 100

  def initialize(tickers:, options:)
    @tickers = tickers
    @options = options
  end

  def payload
    {
      ids: tickers.join(','),
      page: options[:page] || 1,
      'per-page' => options[:per_page] || PER_PAGE
    }
  end
end
