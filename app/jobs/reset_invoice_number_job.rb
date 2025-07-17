class ResetInvoiceNumberJob < ApplicationJob
  queue_as :default

  def perform(*args)
    invoice = InvoiceNumber.first
    invoice.sequency = 1
    invoice.year = Date.today.year
    invoice.save
  end
end
