module Print
    extend ActiveSupport::Concern
    def generate_and_print_invoice(sale, client, invoice_type)
      @sale = sale
      @client = client
      @company = Company.first
      @products = []
      @invoice_number = "001/2025"
      @issue_date = sale[:created_at].utc.strftime("%d-%m-%Y %H:%M:%S")

      sale[:sale_products].each do |item|
        @products.push({
          name: item[:name],
          qty: item[:qty],
          price: item[:price]
        })
      end

      rows = ""

      @products.each_with_index do |product, index|
        rows += <<-ROW
          <tr>
            <td>#{index + 1}</td>
            <td class="item-name">#{product[:name]}</td>
            <td>#{sprintf("%.2f", product[:price])}</td>
            <td>#{product[:qty]} un</td>
            <td>0.00%</td>
            <td>0.00%</td>
            <td>0.00%</td>
            <td class="total-column">#{sprintf("%.2f", product[:price] * product[:qty])}</td>
          </tr>
        ROW
    end

      html_content = <<-HTML
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
          <style>
          *{
        padding: 0;
        font-family: sans-serif;
        margin: 0;}

        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
          }
          body{#{'         '}
              padding: 7px 7px 0 7px;
              margin: 7px 10px 0 10px;
          }
        main {
        flex: 1;
        }

          p {
              margin: 4px 1px;
            }
          h5 {
              margin: 4px 1px;
            }
    #{'        '}
          header div{
              padding: 0 ;
              margin: 0 0 0 10px;
          }

          header div h1{
              font-size: 18pt;
              margin: 4px 0;
          }

          header small{
              padding-left: 10px;
          }
          header div p{
              margin: 4px 5px;
              font-style: italic;
          }
          .companiesHeaders{
              margin-top: 1.5rem;
              display: flex;
              justify-content: space-between;
              width: 100%;
              font-size: 11pt;
          }

          .companiesHeaders div{
              padding: 5px;
          }

          .invoiceType{
              margin-top: 1rem;
              height: 100px;
              width: 100%;
              display: flex;
          }

          .invoiceType div{
              display: flex;
              flex-direction: column;
              gap: 5px;
              font-size: 10pt;
              font-weight: 600;
          }

          .invoiceDetails{
              margin-top: -2rem;
              display: flex;
              justify-content: space-between;
              gap: 14px;
              font-size: 9pt;
          }

          .assignatureWrapper{
              text-align: center;
          }

          /* Estilo para tabelas em vez de grid */
        .items-table {
          width: 100%;
          border-collapse: collapse;
          margin-top: 1rem;
          font-size: 10pt;
        }
    #{'    '}
        .items-table th {
          border-bottom: 1px solid black;
          text-align: left;
          font-weight: 600;
          padding: 3px;
        }
    #{'    '}
        .items-table td {
          padding: 3px;
          font-size: 12px;
        }
    #{'    '}
        .total-column {
          text-align: right;
          font-weight: 600;
        }
    #{'    '}
        .item-name {
          font-weight: 600;
        }
    #{'    '}
        /* Footer items table */
        .footer-items-table {
          width: 60%;
          border-collapse: collapse;
          margin-top: 0.5rem;
        }
    #{'    '}
        .footer-items-table th {
          border-bottom: 1px solid black;
          text-align: left;
          padding: 3px;
          font-size: 10pt;
        }
    #{'    '}
        .footer-items-table td {
          border-bottom: 1px solid rgb(209, 206, 206);
          padding: 3px;
          font-size: 10px;
        }
    #{'  '}
        .footerDetails {
          display: grid !important;
          grid-template-columns: 1fr 1fr 1fr !important;
        /* ou você pode mudar para tabela também */
          }

          .footerDetails{
              display: grid;
              grid-template-columns: repeat(3,30fr) 2fr;
              background-color: white;
          }

          .saleResume{
              padding: 4px;
              display: flex;
              flex-direction: column;
          }

          .saleResume div h6{
              margin: 4px 0;
          }

          .saleResume div{
              display: flex;
              justify-content: space-between;
          }

          .observation{
              font-size: 12pt;
          }

          .bankAccount h5,
          .observation h5{
              margin-bottom: 10px;
          }

          .observation h4{
              margin-top: 1rem;
          }

          footer{
            padding-top: 0.5rem;
            border-top: 1px solid black;
            border-bottom: 1px solid black;
            position: relative;
            bottom: 0;
            width: 100%;
            margin-top: 2rem;
            font-size: 10pt;
        }
          </style>
          <title>Fatura</title>
      </head>
      <body>
          <header>
              <div>
                  <h1>MARIANO TCHIPOIA DOMINGOS</h1>
                  <p>Comercio Geral, Importacao & Exportacao</p>
                  <small>vende - se todo tipo de pecas Genuinas de automoveis</small>
              </div>
          </header>
    #{'      '}
          <div class="companiesHeaders">
              <div>
                  <h5>MARIANO TCHIPOIA DOMINGOS JUNIOR</h5>
                  <p>Endereco: Municipio de Viana, Via Expressa, Bairro Km25</p>
                  <p>NIF: 000910091MO038</p>
                  <p>Telefone: 953 577 264</p>
                  <p>Telefone: 943 737 686</p>
                  <p>Email: marianotchipoia@gmail.com</p>
              </div>
              <div>
              <p>Para:<h5>#{client[:name]}</h5></p>
              <p>Endereco: #{client[:address]}</p>
              <p>NIF: #{client[:nif]}</p>
              <p>Telefone: #{client[:phone]}</p>
              <p>Email: #{client[:email]}</p>
              </div>
          </div>
          <div class="invoiceType">
              <div>
                  <span>Luanda - Angola</span>
                  <span>FATURA #{invoice_type == 2 ? 'PROFORMA' : 'RECIBO'}</span>
              </div>
          </div>
    #{'  '}
          <div class="invoiceDetails">
              <div>
                  <p>FR AGT2025/994</p>
                  <p>REF 1231</p>
              </div>
    #{'  '}
              <div>
                  <p>Moeda: AKZ</p>
              </div>
    #{'  '}
              <div>
                  <p>Cambio: 1,00</p>
              </div>
    #{'  '}
              <div>
                  <p>Data da Factura: #{@issue_date}</p>
                  <p>Forma de Pagamento: #{@sale[:payment_way]}</p>
              </div>
    #{'  '}
              <div class="assignatureWrapper">
                  <p>Operador: #{@sale[:operator]}</p>
                  <p>____________________________</p>
              </div>
          </div>
    #{'  '}
      <main>
        <table class="items-table">
          <thead>
            <tr>
              <th width="30px">N</th>
              <th width="30%">Artigo</th>
              <th width="10%">Preco Unit.</th>
              <th width="10%">Qtd</th>
              <th width="10%">Desc.</th>
              <th width="10%">Taxa</th>
              <th width="10%">Retencao</th>
              <th width="10%">Total</th>
            </tr>
          </thead>
          <tbody>
          #{rows}
          </tbody>
        </table>
    #{'    '}
        <table class="footer-items-table">
          <thead>
            <tr>
              <th width="20%">Taxa/Valor</th>
              <th width="20%">Incid./Qtd</th>
              <th width="20%">Total</th>
              <th width="40%" style="text-align: center;">Motivo Isencao</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>IVA (0,00%)</td>
              <td>175.000,00</td>
              <td>0,00</td>
              <td>Isento nos termos da alinea a) do artigoº do CIVA</td>
            </tr>
          </tbody>
        </table>
      </main>
    <footer style="padding-top: 0.5rem; border-top: 1px solid black; border-bottom: 1px solid black; width: 100%; margin-top: 2rem; font-size: 11pt;">
        <table style="width: 100%; border-collapse: collapse; background-color: white;">
            <tr>
                <!-- Coluna 1: Observações -->
                <td style="width: 33%; vertical-align: top; padding: 5px;">
                    <div class="observation" style="font-size: 10pt;">
                        <h5 style="margin-bottom: 10px;">Observacao</h5>
                        <br/>
                        <p>Os bens/servicos foram colocados a disposicao do adquirente na data do documento</p>
                        <h4 style="margin-top: 1rem;">Regime Geral</h4>
                    </div>
                </td>
    #{'            '}
                <!-- Coluna 2: Dados bancários -->
                <td style="width: 33%; vertical-align: top; padding: 5px;">
                    <div class="bankAccount">
                        <h5 style="margin-bottom: 10px;">COORDENADAS BANCARIAS</h5>
                        <p>BANCO BFA</p>
                        <span style="font-size:10pt">IBAN: AO06 0006 0000 0378 2266 3052 5</span>
                    </div>
                </td>
    #{'            '}
                <!-- Coluna 3: Resumo da venda -->
                <td style="width: 33%; vertical-align: top; padding: 5px;">
                    <table style="width: 100%; border-collapse: collapse;">
                        <tr>
                            <td style="text-align: left; padding: 4px;"><h6 style="margin: 4px 0;">Total da Fatura</h6></td>
                            <td style="text-align: right; padding: 4px;">#{sale[:total]}</td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding: 4px;"><h6 style="margin: 4px 0;">Desconto</h6></td>
                            <td style="text-align: right; padding: 4px;">#{@sale[:descount]},00</td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding: 4px;"><h6 style="margin: 4px 0;">IVA</h6></td>
                            <td style="text-align: right; padding: 4px;">0,00</td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding: 4px;"><h6 style="margin: 4px 0;">Rentencao na fonte (6.5 %)</h6></td>
                            <td style="text-align: right; padding: 4px;">0,00</td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding: 4px;"><h6 style="margin: 4px 0;">Total</h6></td>
                            <td style="text-align: right; padding: 4px;">#{@sale[:total]},00</td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding: 4px;"><h6 style="margin: 4px 0;">Troco</h6></td>
                            <td style="text-align: right; padding: 4px;">#{@sale[:difference]},00</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </footer>
      </body>
      </html>
      HTML

      pdf_content = WickedPdf.new.pdf_from_string(
        html_content,
        page_size: "A4",
        encoding: "UTF-8",
        dpi: 300,
        zoom: 1.0,
        margin: { top: 5, bottom: 5, left: 5, right: 5 },
        print_media_type: true,
        javascript_delay: 1000,
        no_background: false,
      )

      invoice_directory = Rails.root.join("invoices")
      Dir.mkdir(invoice_directory) unless File.directory?(invoice_directory)

      timestamp = Time.now.strftime("%Y%m%d%H%M%S")
      filename = "fatura_#{@invoice_number.gsub('/', '_')}_#{timestamp}.pdf"
      file_path = invoice_directory.join(filename)

      # Salvar o PDF no arquivo
      File.open(file_path, "wb") do |file|
        file.write(pdf_content)
      end

           # #  Imprimir o PDF diretamente
           if Gem.win_platform?
             # Para Windows, use o comando print
             system("print /d:\"HP-Deskjet-Plus-4100-series\" \"{file_path}\"")
           else
             # Para Unix/Linux, use o comando lpr
             system("lpr \"#{file_path}\"")
             #  system("lpr -P \HP-Deskjet-Plus-4100-series\" \"{file_path}\"")
           end

          # if Gem.win_platform?
          #   # For Windows, send to default printer by omitting printer name
          #   system("print \"#{file_path}\"")
          # else
          #   # For Unix/Linux, send to default printer using lpr without -P
          #   system("lpr \"#{file_path}\"")
          # end
          file_path
    end

    def print(sale, client)
     invoiceObject=File.new("gfatura/fatura.json", "w")
     products=[]

     company= Company.first
      sale[:sale_products].each do |item|
        products.push({ nome: item[:name], qtd: item[:qty], preco: item[:price].to_s + " kz" })
      end

       invoiceObject.syswrite({
         empresa: company.name,
         nif: company.nif,
         local: company.address,
         email: company.email,
         empresaPhone: company.phone,
         numeroRecibo: "001/2025",
         dataEmissao: sale[:created_at].utc.strftime("%d-%m-%Y %H:%M:%S"),
         vendedor: sale[:operator],
         troco: sale[:difference].to_s + " kz",
         telefone: client[:phone],
         cliente: sale[:client],
         desconto: sale[:descount].to_s + " kz",
         total: sale[:total].to_s + " kz",
         formaPagamento: sale[:payment_way],
         observacoes: "Lembre-se de seguir as orientações de uso dos medicamentos<br/>Em caso de dúvida, consulte nossa equipe.",
         produto: products
     }.to_json+"\n")
        invoiceObject.close

        Dir.chdir("gfatura") do
          if Gem.win_platform?
            system('java -cp "application.jar;jackson-core-2.17.0.jar;jackson-databind-2.17.0.jar;jackson-annotations-2.17.0.jar" Gfatura')
          else
            system('java -cp "application.jar:jackson-core-2.17.0.jar:jackson-databind-2.17.0.jar:jackson-annotations-2.17.0.jar" Gfatura')
          end
        end
    end
end
