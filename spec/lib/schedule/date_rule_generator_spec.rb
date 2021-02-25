require 'rails_helper'

RSpec.describe Schedule::DateRuleGenerator, type: :lib do
  ## Mock a ContractDetail
  class ContractDetail < OpenStruct; end

  it "should return a array of rules using ContractDetail object" do
      contract_details = []
      contract_details << ContractDetail.new(day: "monday", start_hour: "08:30", hours: 5)
      contract_details << ContractDetail.new(day: "tuesday", start_hour: "08:30", hours: 5)

      rule_generator = Schedule::DateRuleGenerator.new(contract_details)
      date_rules = rule_generator.rules
      date_rule = date_rules.sample

      expect(date_rules.size).to eq(12)

      expect(date_rule).to respond_to(:day)
      expect(date_rule).to respond_to(:hour)
      expect(date_rule).to respond_to(:min)
      expect(date_rule.day.class).to eq(Symbol)
  end
end