class LandingController < ApplicationController

  def index
  end

  def assignment
    company = Company.find(params[:company_id])
    @week = params[:week].to_i
    @company = CompanySerializer.new(company).serialized_json
  end


end