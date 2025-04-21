class Api::CompaniesController < ApplicationController
    before_action :set_company, only: %i[ show destroy update ]

    def index
        @companies=Company.all
        render json: { success: true, data: @companies }, status: :ok
    end

    def show
        render json: { success: true, data: @company }, status: :ok
    end

    def company_fields
        company=Company.column_names
        render json: { success: true, data: product }, status: :ok
    end

    def create
        company = Company.new(company_params)
        if company.save
        render json: { success: true, company: company }, status: :ok
        else
        render json: { error: false, message: company.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        if @company.update(company_params)
        render json: { success: true, company: @company }, status: :ok
        else
        render json: { error: true, message: @company.errors.full_messages }, status: :ok
        end
    end

    def destroy
        if @company.destroy
        render json: { success: true, id: @company.id }, status: :ok
        else
        render json: { error: true, message: @company.errors.full_messages }, status: :ok
        end
    end

    private

    def company_params
        params.expect(company: [ :name, :email, :phone, :address, :nif, :website, :alternative_phone ])
    end

    def set_company
        @company = Company.find_by(id: params[:id])
    end
end
