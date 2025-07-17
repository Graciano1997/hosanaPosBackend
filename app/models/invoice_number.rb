class InvoiceNumber < ApplicationRecord
  def self.next!
    current_year = Date.today.year
    invoice = find_or_create_by(year: current_year)
    number = invoice.sequency
    invoice.increment!(:sequency)

    "#{number.to_s.rjust(3, '0')}/#{current_year}"
  end
end
