require 'rails_helper'

def manual_setup(company)
  3.times do 
    create(:user, company: company)
  end
  #monday 9 hours from 8 to 16 from factories equal to 9 block per day
  create(:contract_schedule, day: 1, contract: company.contract) 
  #thuesday 9 hours from 8 to 16 from factories equal to 9 block per day
  create(:contract_schedule, day: 2, contract: company.contract) 
end

RSpec.describe Company, type: :model do

  let!(:company){ create(:company) }
  # contract for a week
  let!(:contract){ create(:contract, company: company, start_date: Time.zone.today, end_date: (Time.zone.today + 1.week)) }

  describe ".create_schedules" do
    it "should create records in table company_schedules" do 
      manual_setup(company)
      
      expect {
        company.create_schedules!
      }.to change(company.company_schedules, :count).by(18) #9 blocks for day 1 and 9 blocks for day 2
    end
  end
end