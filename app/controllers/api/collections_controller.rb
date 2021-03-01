module Api
  class CollectionsController < BaseController

    def companies
      companies = Company.all
      render json: CompanySerializer.new(companies).serialized_json
    end

    def weeks
      company = Company.find(params[:company_id])
      weeks = company.weeks_collection
      render json: { data: weeks } 
    end

    def users
      company = Company.find(params[:company_id])
      users = company.users
      render json: UserSerializer.new(users).serialized_json
    end
  end
end