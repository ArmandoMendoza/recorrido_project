module Api
  class Companies::UsersController < BaseController
    before_action :set_company
    before_action :set_user, except: [:create]

    def create
      user = @company.users.new(user_params)
      if user.save
        @company.create_user_schedules!(user.id)
        render json: UserSerializer.new(user).serialized_json, status: :created
      else
        render json: user.errors.full_messages, status: 422
      end
    end

    def schedules
      week = (params.fetch(:week, nil) || Time.zone.today.cweek).to_i
      render json: {
        data: @user.schedules_for_week(week)
      }
    end

    def set_availability
      block = params.fetch(:block, nil)
      if block
        value = @user.set_availability!(block: block)
        render json: { available: value }
      end
    end

    def unset_availability
      block = params.fetch(:block, nil)
      if block
        value = @user.unset_availability!(block: block)
        render json: { available: value }
      end
    end

    private

    def set_company
      @company = Company.find(params[:company_id])
    end

    def set_user
      @user = @company.users.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :color)
    end

  end
end