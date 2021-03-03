require 'rails_helper'


RSpec.describe Api::Companies::UsersController, type: :request do

  def response_body
    JSON.parse(response.body)
  end
  

  describe "GET api/companies/id/users/id/schedules" do
    
    it "should return the schedules of user by the week given" do

      start_date = Time.zone.today.beginning_of_week
      end_date = start_date + 2.weeks
      company = create(:company)
      contract = create(:contract, company: company, start_date: start_date, end_date: end_date)
      contract.contract_schedules.find_or_create_by!(day: "monday",    start_hour: "19:00", hours: 1)
      contract.contract_schedules.find_or_create_by!(day: "tuesday",   start_hour: "19:00", hours: 1)
      week = Time.zone.today.strftime("%W")
      company.create_schedules!
      user = create(:user, company: company)
      company.create_user_schedules!(user.id)

      get schedules_api_company_user_path(company, user), { params: { week: week } }

      # expect_any_instance_of(Company).to receive(:assignment_process_for_week).and_return(nil)

      expect(response_body["data"].size).to eq(2)

      schedule = response_body["data"].sample

      expect(schedule).to have_key("date")
      expect(schedule).to have_key("values")
      # expect(schedule).to have_key("available")
    end
    
  end


  describe "POST api/companies/id/users" do
    
    it "should create a user for company" do

      start_date = Time.zone.today.beginning_of_week
      end_date = start_date + 2.weeks

      company = create(:company)
      contract = create(:contract, company: company, start_date: start_date, end_date: end_date)
      contract.contract_schedules.find_or_create_by!(day: "monday",    start_hour: "19:00", hours: 1)

      params = {
        user: {
          name: "User 1",
          color: "#FFFFF"
        } 
      }

      expect {
        post api_company_users_path(company), { params: params }

      }.to change(User, :count).by(1)

      # expect_any_instance_of(Company).to receive(:create_user_schedules!).and_return(nil)


      expect(response_body["data"]).to have_key("id")
      expect(response_body["data"]).to have_key("attributes")

    end
    
  end

end