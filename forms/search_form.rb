require 'virtus'
require 'active_model'

##
# String attribute for form objects of SearchForm
class StringStripped < Virtus::Attribute
  def coerce(value)
    value.is_a?(String) ? value.strip : nil
  end
end

##
# Form object
class SearchForm
  include Virtus.model
  include ActiveModel::Validations

  attribute :keyword, StringStripped

  validates :keyword, presence: true

  def error_fields
    errors.messages.keys.map(&:to_s).join(', ')
  end
end
