class Company < ApplicationRecord

  ### Relations
  has_one :contract
  has_many :users
  has_many :company_schedules
  has_many :user_schedules
  has_many :contract_schedules, through: :contract

  ### Validations
  validates_presence_of :name

  ### Instance Methods

  def available_users
    users
  end

  def assigned_days_for_week(week)
    company_schedules.by_week(week).pluck(:day).uniq.sort
  end

  def create_schedules!(start_date: nil, end_date: nil)
    s_date = start_date || contract.start_date
    e_date = end_date   || contract.end_date
    
    date_rules = Schedule::DateRuleGenerator.new(contract_schedules).rules
    dates = Schedule::DateGenerator.new(start_date: s_date, end_date: e_date, date_rules: date_rules).dates
    
    dates.each do |date|
      company_schedules.find_or_create_by!(date)

      available_users.each do |user|
        user_schedules.find_or_create_by!(date.merge(user: user))
      end
    end
  end

  def specs_by_day(week:, day:)
    hsh = { day: day, blocks: [] }
    schedules = company_schedules.by_week(week).by_day(day)
    
    schedules.each do |schedule|
      hsh[:blocks] << schedule.block
    end

    hsh[:demand] = hsh[:blocks].size
    hsh
  end

  def specs_for_week(week)
    hsh = {}
    assigned_days_for_week(week).each do |day|
      hsh[day] = specs_by_day(week: week, day: day)
    end
    hsh
  end

  def users_specs_for_week(week)
    hsh = {}
    assigned_days_for_week(week).each do |day|
      users_specs = []
      available_users.each do |user|
        spec = user.specs_by_day(week: week, day: day)
        users_specs << spec if spec
      end
      hsh[day] = users_specs
    end
    hsh
  end

end
