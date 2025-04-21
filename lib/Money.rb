module Money
  include ActionView::Helpers::NumberHelper
  def format_money(item)
    number_to_currency(item, unit: "", separator: ",", delimiter: ".", precision: 2)
  end
end
