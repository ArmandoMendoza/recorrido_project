require 'rails_helper'


RSpec.describe Company, type: :model do

  let!(:company){ create(:company) }
  # contract for a week
  let!(:contract) do 
    start_date = Time.zone.today.beginning_of_week
    end_date = start_date + 1.week
    create(:contract, company: company, start_date: start_date, end_date: end_date)
  end

  def manual_setup(company)
    3.times do 
      create(:user, company: company)
    end
    #monday 8 hours from 8 to 16 from factories equal to 8 block per day
    create(:contract_schedule, day: 1, contract: company.contract) 
    #thuesday 8 hours from 8 to 16 from factories equal to 8 block per day
    create(:contract_schedule, day: 2, contract: company.contract) 
  end

  describe "#create_schedules" do
    
    before do  
      manual_setup(company)
    end
    
    it "should create records in table company_schedules" do   
      expect {
        company.create_schedules!
      }.to change(company.company_schedules, :count).by(16) #8 blocks for day 1 and 8 blocks for day 2
    end
  end

  describe "#create_user_schedule" do

    before do  
      manual_setup(company)
    end

    it "should create records in table user_schedules for each user available" do 
      user = company.users.sample
      expect {
        company.create_user_schedules!(user.id)
      }.to change(company.user_schedules, :count).by(16) #8 blocks for day 1 and 8 blocks for day 2
      
      expect(user.user_schedules.count).to eq(16)
    end
  end

end