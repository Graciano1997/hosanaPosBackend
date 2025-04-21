module YearBalance
  extend ActiveSupport::Concern


  def anual_Balance(model, key, year, date_field: "created_at")
    current_year = year
    monthly_total=[]
    model_name=model.classify
    model_class=model_name.constantize
    date_field = date_field.to_s

    if Time.now.year==current_year
      (1..Time.now.month).each do |month|
        current_month=Date.new(current_year, month, 1)
        range = current_month..current_month.end_of_month
        monthly_total << model_class.where(date_field => range).sum(key.to_sym)
      end
    else
      (1..12).each do |month|
        current_month=Date.new(current_year, month, 1)
        monthly_total << model_class.where(date_field: current_month..current_month.end_of_month).sum(key.to_sym)
      end
    end
    render json: { success: true, data: monthly_total }, status: :ok
  end
end
