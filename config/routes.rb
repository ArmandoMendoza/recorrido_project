Rails.application.routes.draw do

  root to: "landing#index"

  get "companies/:company_id/week/:week", to: "landing#assignment"

  namespace :api do

    scope :collections do
      get :companies, to: "collections#companies", as: :companies_collection
      get "companies/:company_id/weeks", to: "collections#weeks", as: :companies_weeks_collection
      get "companies/:company_id/users", to: "collections#users", as: :companies_users_collection
    end

    resources :companies, only: [:create] do
      member do
        get :schedules
      end

      resources :users, only: [:create], module: :companies do
        member do
          get :schedules
          put :set_availability
          put :unset_availability
        end
      end
    end

  end

end
