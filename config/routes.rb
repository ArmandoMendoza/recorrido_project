Rails.application.routes.draw do

  root to: "landing#index"

  namespace :api do

    scope :collections do
      get :companies, to: "collections#companies", as: :companies_collection
      get "companies/:company_id/weeks", to: "collections#weeks", as: :company_weeks
      get "companies/:company_id/users", to: "collections#users", as: :company_users
    end

    resources :companies, only: [:show] do

      member do
        get :schedules
      end
    end

  end

end
