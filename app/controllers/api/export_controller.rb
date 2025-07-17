# this controller is responsible for exporting data to Excel format...
## it uses the Axlsx gem to create the Excel file and send it as a response to the client.
#
# The controller has a single action, to_excel, which takes the model name and columns as parameters.
# It retrieves the records from the specified model, creates an Excel file with the specified columns, and sends it as a response.
# The controller uses the Axlsx gem to create the Excel file and styles the header row with a green background and black text.
# The file is named based on the model name and the current date, and it is sent as an attachment in the response.

class Api::ExportController < ApplicationController
  include ActionController::MimeResponds
  def to_excel
    model_name=params[:model].classify
    model_class=model_name.constantize

    @records = model_class.order(id: :asc)

    columns = params[:columns].present? ? params[:columns].map(&:to_sym) : model_class.column_names.map(&:to_sym)

    require "caxlsx"

    p=Axlsx::Package.new
    wb = p.workbook

    styles = wb.styles

    header_style = styles.add_style(
    bg_color: "86efac",
    fg_color: "000000",
    b: true,
    alignment: { horizontal: :center }
    )

    file_name = "#{model_name.underscore.pluralize}_#{Date.today.strftime('%Y%m%d')}.xlsx"

    wb.add_worksheet(name: model_name.pluralize) do |sheet|
      sheet.add_row columns.map { |col| col.to_s.humanize }, style: header_style
      @records.each do |record|
        sheet.add_row [
          record.id,
          record.name,
          record.email,
          record.created_at
        ]
      end
    end

    send_data p.to_stream.read,
    type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    filename: file_name,
    disposition: "attachment"
  end
end
