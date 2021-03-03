require 'rails_helper'


RSpec.describe Api::CollectionsController, type: :request do

  def response_body
    JSON.parse(response.body)
  end
  
  describe "GET api/collections/companies" do
    
    it "should return a collection of companies" do
      3.times do
        create(:company)
      end
      get api_companies_collection_path
      expect(response_body["data"].size).to eq(3)
    end

  end

  describe "GET api/collections/companies/id/weeks" do
    
    it "should return a collection of objects with the information to create an selector weeks" do
      start_date = Time.zone.today.beginning_of_week
      end_date = start_date + 5.weeks
      company = create(:company)
      create(:contract, company: company, start_date: start_date, end_date: end_date)
      company.create_schedules!

      get api_companies_weeks_collection_path(company)
      expect(response_body["data"].size).to eq(6)
      week = response_body["data"].sample

      expect(week).to have_key("name")
      expect(week).to have_key("value")
    end
    
  end

  describe "GET api/collections/companies/id/users" do
    
    it "should return a collection of users of company" do
      company = create(:company)
      3.times do
        create(:user, company: company)
      end
      get api_companies_users_collection_path(company)
      expect(response_body["data"].size).to eq(3)
      user = response_body["data"].sample

      expect(user).to have_key("id")
      expect(user).to have_key("attributes")
    end
    
  end
end