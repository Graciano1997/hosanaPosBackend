class Api::ProductConfigurationsController < ApplicationController
  def index
    @productConfigurations=ProductConfiguration.all.order(id: :asc)
    render json: { success: true, data: @productConfigurations }, status: :ok
  end

  def create
    if params["_json"].size > 0
      params["_json"].each do |item|
      productConfiguration = ProductConfiguration.find_by(field: item[:field])
     if productConfiguration
       productConfiguration.update(field: item[:field], active: item[:active], mandatory: item[:mandatory])
     else
       productConfiguration=ProductConfiguration.new(field: item[:field], active: item[:active], mandatory: item[:mandatory])
       productConfiguration.save
     end
    end
    end
    render json: { success: true }, status: :ok
  end

  # private

  # def productConfiguration_params
  #   params.expect(productConfiguration: [ :field, :active, :mandatory ])
  # end
end
