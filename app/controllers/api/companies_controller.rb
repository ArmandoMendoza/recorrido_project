module Api
  class CompaniesController < BaseController


    def create
      company = Company.new(company_params)
      if company.save
        company.create_schedules!
        render json: company, status: :created
      else
        render json: company.errors.full_messages, status: 422
      end
    end

    def schedules
      week = (params.fetch(:week, nil) || Time.zone.today.cweek).to_i
      company = Company.find(params[:id])
      company.assignment_process_for_week(week)
      render json: { 
        data: { 
          schedules: company.schedules_for_week(week), 
          total: company.total_assignment_for_week(week) 
        } 
      }
    end

    private

    def company_params
      params.require(:company).permit(:name, contract_attributes: [:start_date, :end_date, contract_schedules_attributes: [:day, :start_hour, :hours]])
    end

  end
end