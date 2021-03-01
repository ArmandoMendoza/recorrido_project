module Api
  class CompaniesController < BaseController

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

  end
end