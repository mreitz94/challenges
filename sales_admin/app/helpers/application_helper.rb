module ApplicationHelper
  def dollar_format(amt)
    number_to_currency amt.to_f
  end
end
