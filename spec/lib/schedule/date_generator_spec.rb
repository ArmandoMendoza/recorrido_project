require 'rails_helper'

RSpec.describe Schedule::DateGenerator, type: :lib do
  ## Mock a ContractDetail
  class ContractDetail < OpenStruct; end

  it "should return a array of hash using date_rules" do
      contract_details = []
      contract_details << ContractDetail.new(day: "monday", start_hour: "08:30", hours: 5)
      contract_details << ContractDetail.new(day: "friday", start_hour: "08:30", hours: 5)

      start_date = Time.zone.today
      end_date = start_date + 5.week

      rule_generator = Schedule::DateRuleGenerator.new(contract_details)
      date_rules = rule_generator.rules

      date_generator = Schedule::DateGenerator.new(start_date: start_date, end_date: end_date, date_rules: date_rules)
      dates = date_generator.dates
      
      # date is a hash like { week: 1, date: Time, day: 1 }
      date = dates.sample

      expect(date).to have_key(:date)
      expect(date[:date].class).to eq(Time)

      expect(date).to have_key(:week)
      expect(date[:week].class).to eq(Integer)

      expect(date).to have_key(:day)
      expect(date[:day].class).to eq(Integer)
  end
end