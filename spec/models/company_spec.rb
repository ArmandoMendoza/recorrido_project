require 'rails_helper'

def manual_setup(company)
  3.times do 
    create(:user, company: company)
  end
  #monday 8 hours from 8 to 16 from factories 
  create(:contract_schedule, day: 1, contract: company.contract) 
  #thuesday 8 hours from 8 to 16 from factories
  create(:contract_schedule, day: 2, contract: company.contract) 
end

RSpec.describe Company, type: :model do

  let!(:company){ create(:company) }
  let!(:contract){ create(:contract, company: company) }

  describe ".create_schedules" do
    it "should create record in table company_schedules" do 
      manual_setup(company)

      start_date = Time.zone.now
      end_date = start_date + 1.week

      date_rules = Schedule::DateRuleGenerator.new(company.contract_schedules).rules
      @company.create_schedules(start_date: start_date, end_date: end_date, date_rules: date_rules)
    end
  end
end