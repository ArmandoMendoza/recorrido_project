class Company < ApplicationRecord

  ### Relations
  has_one :contract
  has_many :users
  has_many :company_schedules
  has_many :contract_schedules, through: :contract

  ### Validations
  validates_presence_of :name

  ### Instance Methods

  def available_users
    users
  end

  def create_schedules!(start_date: nil, end_date: nil)

     s_date = start_date || contract.start_date
     e_date = end_date   || contract.end_date
    
    date_rules = Schedule::DateRuleGenerator.new(contract_schedules).rules
    dates = Schedule::DateGenerator.new(start_date: s_date, end_date: e_date, date_rules: date_rules).dates
    
    dates.each do |date|
      company_schedules.find_or_create_by!(date)
    end
  end

end
