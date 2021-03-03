require 'rails_helper'


RSpec.describe Api::CompaniesController, type: :request do

  def response_body
    JSON.parse(response.body)
  end
  

  describe "GET api/companies/id/schedules" do
    
    it "should return the schedules of company by the week given" do

      start_date = Time.zone.today.beginning_of_week
      end_date = start_date + 2.weeks
      company = create(:company)
      contract = create(:contract, company: company, start_date: start_date, end_date: end_date)
      contract.contract_schedules.find_or_create_by!(day: "monday",    start_hour: "19:00", hours: 1)
      contract.contract_schedules.find_or_create_by!(day: "tuesday",   start_hour: "19:00", hours: 1)
      week = Time.zone.today.strftime("%W")
      company.create_schedules!
      

      get schedules_api_company_path(company), { params: { week: week } }

      # expect_any_instance_of(Company).to receive(:assignment_process_for_week).and_return(nil)

      expect(response_body["data"]).to have_key("schedules")
      expect(response_body["data"]).to have_key("total")
      expect(response_body["data"]["schedules"].size).to eq(2)

      schedule = response_body["data"]["schedules"].sample

      expect(schedule).to have_key("date")
      expect(schedule).to have_key("values")
    end
    
  end


  describe "POST api/companies/id/schedules" do
    
    it "should create company with contract and contract_schedules if the params are given" do

      params = {
        company: {
          name: "Testing",
          contract_attributes: {
            start_date: Time.zone.today,
            end_date: (Time.zone.today + 1),
            contract_schedules_attributes: [
              { day: "monday", start_hour: "08:00", hours: 4 }
            ]
          }
        } 
      }

      expect {
        post api_companies_path, { params: params }

      }.to change(Company, :count).by(1)

      expect {
        post api_companies_path, { params: params }

      }.to change(Contract, :count).by(1)

      expect {
        post api_companies_path, { params: params }

      }.to change(ContractSchedule, :count).by(1)

      expect(response_body["data"]).to have_key("id")
      expect(response_body["data"]).to have_key("attributes")

    end
    
  end

end