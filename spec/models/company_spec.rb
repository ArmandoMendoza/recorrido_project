require 'rails_helper'

def manual_setup(company)
  3.times do 
    create(:user, company: company)
  end
  #monday 8 hours from 8 to 16 from factories equal to 8 block per day
  create(:contract_schedule, day: 1, contract: company.contract) 
  #thuesday 8 hours from 8 to 16 from factories equal to 8 block per day
  create(:contract_schedule, day: 2, contract: company.contract) 
end

RSpec.describe Company, type: :model do

  let!(:company){ create(:company) }
  # contract for a week
  let!(:contract){ create(:contract, company: company, start_date: Time.zone.today, end_date: (Time.zone.today + 1.week)) }


  describe ".create_schedules" do
    
    before do  
      manual_setup(company)
    end
    
    it "should create records in table company_schedules" do   
      expect {
        company.create_schedules!
      }.to change(company.company_schedules, :count).by(16) #8 blocks for day 1 and 8 blocks for day 2
    end

    it "should create records in table user_schedules for each user available" do 
      expect {
        company.create_schedules!
      }.to change(company.user_schedules, :count).by(48) #8 blocks for day 1 and 8 blocks for day 2 * 3
      
      user = company.available_users.sample

      expect(user.user_schedules.count).to eq(16)
    end
  end
end