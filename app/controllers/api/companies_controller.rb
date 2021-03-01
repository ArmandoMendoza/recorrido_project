module Api
  class CompaniesController < BaseController

    def schedules
      week = params.fetch(:week, nil) || Time.zone.today.cweek
      company = Company.find(params[:id])
      schedules = company.schedules_for_week(week.to_i)
      render json: { data: schedules }
    end

  end
end