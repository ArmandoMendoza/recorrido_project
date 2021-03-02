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

    def set_availability
      block = params.fetch(:block, nil)
      @user.set_availability!(block: block) if block
    end

    def unset_availability
      block = params.fetch(:block, nil)
      @user.unset_availability!(block: block) if block
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