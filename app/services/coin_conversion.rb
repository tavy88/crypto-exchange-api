class CoinConversion
  attr_reader :from, :to, :data

  def initialize(from:, to:, data:)
    @from = from
    @to = to
    @data = data
  end

  def result
    raise Nomics::APIError, I18n.t('services.nomics.errors.missing_conversion_coin') if from.nil? || to.nil?

    ratio = coin_price(from) / coin_price(to)

    "1 #{from} = #{ratio} #{to}"
  end

  private

  def coin_price(id)
    data.detect { |c| c['id'] == id }['price'].to_f
  end
end
