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

    company.create_user_schedules!(user1.id)
    company.create_user_schedules!(user2.id)

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
      
      expect(algorithm.run).to match_array(expect_array)
      # expect(algorithm.counter_assigment).to eq({ user1.id => 4, user2.id => 4 })
    end
  end

  describe "#specs_for_week" do
    before do
      manual_setup(company)
      company.create_schedules!
    end

    it "should return a hash with information about the assigned blocks for company to use with the simple assigment algorithm" do
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

    it "should return a hash with information about the users availabilities for given week to use with the simple assigment algorithm" do
      cw = Time.zone.today.strftime("%W").to_i


      expected_hash = {
        1 => [
          { :blocks => ["#{cw}18".to_i, "#{cw}19".to_i, "#{cw}113".to_i, "#{cw}114".to_i], :day => 1, :offer => 4, :user_id => @user1.id },
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
