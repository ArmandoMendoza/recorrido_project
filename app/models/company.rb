class Company < ApplicationRecord

  ### Relations
  has_one :contract
  has_many :users
  has_many :company_schedules

  ### Validations
  validates_presence_of :name

  ### Instance Methods

  def create_schedules(start_time:, end_time:, date_rules:)
    contract_schedules = contract.contract_schedules

    rule_generator = Schedule::DateRuleGenerator.new(contract_schedules)
    date_rules = rule_generator.rules

    date_generator = Schedule::DateGenerator.new(start_date: start_date, end_date: end_date, date_rules: date_rules)
    dates = date_generator.dates

    dates.each do |date|
      company_schedules.find_or_create_by!(date)
    end
  end

end
