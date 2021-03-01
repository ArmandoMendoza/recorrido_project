class LandingController < ApplicationController

  def index
  end

  def assignment
    @company = Company.find(params[:company_id])
    @week = params[:week]
  end


end