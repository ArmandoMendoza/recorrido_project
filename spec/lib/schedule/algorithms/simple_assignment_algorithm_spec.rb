require 'rails_helper'


RSpec.describe Schedule::Algorithms::SimpleAssignmentAlgorithm, type: :lib do
  
  def manual_setup(company)
    3.times do 
      create(:user, company: company)
    end
    #monday 8 hours from 8 to 16 from factories equal to 8 block per day
    create(:contract_schedule, day: 1, contract: company.contract) 
    #thuesday 8 hours from 8 to 16 from factories equal to 8 block per day
    create(:contract_schedule, day: 2, contract: company.contract)
    
    cw = Time.zone.today.strftime("%W").to_i
    
    company.create_schedules!

    user1 = company.users.first
    user2 = company.users.second

    user1.set_availability!(block: "#{cw}18".to_i)
    user1.set_availability!(block: "#{cw}19".to_i)
    user1.set_availability!(block: "#{cw}113".to_i)
    user1.set_availability!(block: "#{cw}114".to_i)

    user2.set_availability!(block: "#{cw}113".to_i)
    user2.set_availability!(block: "#{cw}114".to_i)
    user2.set_availability!(block: "#{cw}115".to_i)

    user2.set_availability!(block: "#{cw}28".to_i)
    user2.set_availability!(block: "#{cw}29".to_i)
    user2.set_availability!(block: "#{cw}210".to_i)
  end

  let!(:company){ create(:company) }

  let!(:contract) do 
    start_date = Time.zone.today.beginning_of_week
    end_date = start_date + 1.week
    create(:contract, company: company, start_date: start_date, end_date: end_date)
  end

  describe "#run" do
    it "should return a array of hash with the block and user id assigment" do
      manual_setup(company)
      user1 = company.users.first
      user2 = company.users.second

      current_week = Time.zone.today.strftime("%W").to_i
      company_specs = company.specs_for_week(current_week)
      users_specs = company.users_specs_for_week(current_week)

      expect_array = [
        { :block => "#{current_week}18".to_i, :user_id => user1.id },
        { :block => "#{current_week}19".to_i, :user_id => user1.id },
        { :block => "#{current_week}113".to_i, :user_id => user1.id },
        { :block => "#{current_week}114".to_i, :user_id => user1.id },
        { :block => "#{current_week}115".to_i, :user_id => user2.id },
        { :block => "#{current_week}28".to_i, :user_id => user2.id },
        { :block => "#{current_week}29".to_i, :user_id => user2.id },
        { :block => "#{current_week}210".to_i, :user_id => user2.id }
      ]

      algorithm = Schedule::Algorithms::SimpleAssignmentAlgorithm.new(company_specs: company_specs, users_specs: users_specs)
      
      expect(algorithm.run).to eq(expect_array)
      expect(algorithm.assigment).to eq({ user1.id => 4, user2.id => 4 })
    end
  end 
end
