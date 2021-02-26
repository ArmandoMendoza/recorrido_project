require 'rails_helper'

RSpec.describe Schedule::DateRuleGenerator, type: :lib do
  class ContractScheduleMock < OpenStruct; end

  it "should return a array of rules using ContractSchedule object" do
    
    contract_schedules = []
    contract_schedules << ContractScheduleMock.new(day: "monday", start_hour: "08:30", hours: 5)
    contract_schedules << ContractScheduleMock.new(day: "sunday", start_hour: "08:30", hours: 5)

    rule_generator = Schedule::DateRuleGenerator.new(contract_schedules)
    date_rules = rule_generator.rules
    date_rule = date_rules.sample

    expect(date_rules.size).to eq(10)

    expect(date_rule).to respond_to(:day)
    expect(date_rule).to respond_to(:hour)
    expect(date_rule).to respond_to(:min)
    expect(date_rule.day.class).to eq(Symbol)
  end
end