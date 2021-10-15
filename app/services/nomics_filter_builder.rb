class NomicsFilterBuilder
  attr_reader :filters, :response_hash

  def initialize(filters:, response_hash:)
    @filters = filters
    @response_hash = response_hash
  end

  def apply_filters
    return response_hash unless filters.present?

    raise Nomics::APIError, I18n.t('services.nomics.errors.filters_format') unless filters.is_a?(Array)

    filtered_response = response_hash[:response].each_with_object([]) do |hash, arr|
      arr << hash.slice(*filters)
    end

    { response: filtered_response, total_items: response_hash[:total_items] }
  end
end
