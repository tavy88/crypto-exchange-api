class CurrenciesController < ApplicationController
  def tickers
    data = Nomics.new.currencies_ticker(
      tickers: ids,
      filters: filters,
      options: {
        per_page: per_page,
        page: page,
        currency: currency
      }
    )

    render json: data
  end

  def convert
    data = Nomics.new.convert(
      from: from,
      to: to
    )

    render json: data
  end

  private

  def ticker_params
    params.permit(
      :ids,
      :filters,
      :per_page,
      :page,
      :currency,
      :from,
      :to
    )
  end

  def ids
    ticker_params[:ids].split(',')
  end

  def filters
    ticker_params[:filters]&.split(',')
  end

  def per_page
    ticker_params[:per_page]
  end

  def page
    ticker_params[:page]
  end

  def currency
    ticker_params[:currency]
  end

  def from
    ticker_params[:from]
  end

  def to
    ticker_params[:to]
  end
end
