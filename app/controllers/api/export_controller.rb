class Api::ExportController < ApplicationController
  include ActionController::MimeResponds
  def to_excel
    model_name=params[:model].classify
    model_class=model_name.constantize

    @records = model_class.order(id: :asc)
    # @records = User.where("created_at >= ?", 1.month.ago) # Exemplo de filtro

    columns = params[:columns].present? ? params[:columns].map(&:to_sym) : model_class.column_names.map(&:to_sym)

    require "caxlsx"

    p=Axlsx::Package.new
    wb = p.workbook

    styles = wb.styles

    header_style = styles.add_style(
    bg_color: "86efac",  # Tailwind green-300
    # ou
    # bg_color: "bbf7d0",  # Tailwind green-200
    fg_color: "000000",  # Texto preto para contrastar com o fundo verde claro
    b: true,             # Negrito
    alignment: { horizontal: :center }
    )

    # header = styles.add_style bg_color: "00", fg_color: "FF", sz: 12, bold: true, border: { style: :thin, color: "000000" }

    # header_style = styles.add_style(
    #   bg_color: "336699",     # Cor de fundo azul - você pode usar qualquer código de cor HEX
    #   fg_color: "FFFFFF",     # Cor do texto branco
    #   b: true,               # Negrito
    #   alignment: { horizontal: :center }  # Alinhamento centralizado
    # )
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
