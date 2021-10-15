class NomicsPayloadBuilder
  attr_reader :tickers, :options

  PER_PAGE = 100

  def initialize(tickers:, options:)
    @tickers = tickers
    @options = options
  end

  def payload
    raise Nomics::APIError, I18n.t('services.nomics.errors.tickers_format') unless tickers.is_a?(Array)

    raise Nomics::APIError, I18n.t('services.nomics.errors.options_format') unless options.is_a?(Hash)

    {
      ids: tickers.join(','),
      page: options[:page] || 1,
      'per-page' => options[:per_page] || PER_PAGE
    }
  end
end
