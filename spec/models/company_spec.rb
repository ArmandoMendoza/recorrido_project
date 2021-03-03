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

  describe "#specs_for_week" do
    before do
      manual_setup(company)
      company.create_schedules!
    end

    it "should return a hash with information about the assigned blocks for given week" do
      cw = Time.zone.today.strftime("%W").to_i
      expected_hash = {
        1 => { :blocks => ["#{cw}18".to_i, "#{cw}19".to_i, "#{cw}110".to_i, "#{cw}111".to_i, "#{cw}112".to_i, "#{cw}113".to_i, "#{cw}114".to_i, "#{cw}115".to_i], :day => 1, :demand => 8 }, 
        2 => { :blocks => ["#{cw}28".to_i, "#{cw}29".to_i, "#{cw}210".to_i, "#{cw}211".to_i, "#{cw}212".to_i, "#{cw}213".to_i, "#{cw}214".to_i, "#{cw}215".to_i], :day => 2, :demand => 8 }
      }

      spec = company.specs_for_week(cw)
      expect(spec).to eq(expected_hash)
    end
  end

  describe "#users_specs_for_week" do
    before do
      manual_setup(company)
      @user1 = company.users.first
      @user2 = company.users.second
      company.create_schedules!
      company.create_user_schedules!(@user1.id)
      company.create_user_schedules!(@user2.id)
    end

    it "should return a hash with information about the users availabilities for given week" do
      cw = Time.zone.today.strftime("%W").to_i

      @user1.set_availability!(block: "#{cw}18".to_i)
      @user1.set_availability!(block: "#{cw}19".to_i)
      @user1.set_availability!(block: "#{cw}110".to_i)

      @user2.set_availability!(block: "#{cw}113".to_i)
      @user2.set_availability!(block: "#{cw}114".to_i)
      @user2.set_availability!(block: "#{cw}115".to_i)

      @user2.set_availability!(block: "#{cw}28".to_i)
      @user2.set_availability!(block: "#{cw}29".to_i)
      @user2.set_availability!(block: "#{cw}210".to_i)

      expected_hash = {
        1 => [
          { :blocks => ["#{cw}18".to_i, "#{cw}19".to_i, "#{cw}110".to_i], :day => 1, :offer => 3, :user_id => @user1.id },
          { :blocks => ["#{cw}113".to_i, "#{cw}114".to_i, "#{cw}115".to_i], :day => 1, :offer => 3, :user_id => @user2.id } 
        ], 
        2 => [
          { :blocks => ["#{cw}28".to_i, "#{cw}29".to_i, "#{cw}210".to_i], :day => 2, :offer => 3, :user_id => @user2.id }
        ]
      }


      spec = company.users_specs_for_week(cw)
      expect(spec).to eq(expected_hash)
    end
  end

end