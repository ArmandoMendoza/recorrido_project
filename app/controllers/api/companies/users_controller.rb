module Api
  class Companies::UsersController < BaseController
    before_action :set_company
    before_action :set_user

    def index
    end

    def schedules
      week = (params.fetch(:week, nil) || Time.zone.today.cweek).to_i
      render json: {
        data: @user.schedules_for_week(week)
      }
    end


    private

    def set_company
      @company = Company.find(params[:company_id])
    end

    def set_user
      @user = @company.users.find(params[:id])
    end

  end
end