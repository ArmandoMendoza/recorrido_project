class Company < ApplicationRecord
  # include OrToolAlgorithmMethods
  include SimpleAssignmentAlgorithmMethods
  
  ### Relations
  has_one :contract
  has_many :users
  has_many :company_schedules
  has_many :user_schedules
  has_many :contract_schedules, through: :contract

  ### Validations
  validates_presence_of :name

  accepts_nested_attributes_for :contract

  ### Instance Methods
  def weeks_collection
    old_weeks = company_schedules.where("time < ?", Time.zone.today).pluck(:time).uniq.map do |time|
      [time.in_time_zone("Santiago").to_date.cweek, time.in_time_zone("Santiago").to_date.year]
    end.uniq
    next_weeks = (Time.zone.today..Time.zone.today + 5.weeks).to_a.map do |time|
      [time.in_time_zone("Santiago").to_date.cweek, time.in_time_zone("Santiago").to_date.year]
    end.uniq
    (old_weeks + next_weeks).uniq.map do |week|
      { value: week[0], name: "#{week[0]} of #{week[1]}" }
    end
  end

  def available_users
    users
  end

  def assigned_days_for_week(week)
    company_schedules.by_week(week).pluck(:day).uniq.sort
  end

  def create_schedules!(start_date: nil, end_date: nil)
    s_date = start_date || contract.start_date
    e_date = end_date   || contract.end_date

    dates = generate_dates(s_date, e_date)
    dates.each do |date|
      company_schedules.find_or_create_by!(date)
    end
  end

  def create_user_schedules!(user_id, start_date: nil, end_date: nil)
    user = users.find_by(id: user_id)

    s_date = start_date || contract.start_date
    e_date = end_date   || contract.end_date
    
    if user
      dates = generate_dates(s_date, e_date)
      dates.each do |date|
        user_schedules.find_or_create_by!(date.merge(user: user))
      end
    end
  end

  def schedules_for_week(week)
    hsh = {}
    company_schedules.by_week(week).each do |schedule|
      date = schedule.time.in_time_zone("Santiago").strftime("%A %d of %B")
      data_hash = { id: schedule.id, hour: schedule.hour_block, name: schedule&.user&.name, color: schedule&.user&.color }
      if hsh[date]
        hsh[date] << data_hash
      else
        hsh[date] = [data_hash] 
      end
    end
    array = []
    hsh.each do |k, v|
      array << { date: k, values: v }
    end
    array
  end

  def total_assignment_for_week(week)
    array = []
    totals = CompanySchedule.unscoped.by_week(week).where(company_id: id).joins(:user).group("users.name").count
    if totals.any?
      totals.each do |k,v|
        array << { name: k, total: v }
      end
      unassigned = company_schedules.by_week(week).where(user_id: nil).count
      array << { name: "Unassigned", total: unassigned }
    end
    array
  end

  ## --------------------

  private 
    
  def generate_dates(start_date, end_date)    
    date_rules = Schedule::DateRuleGenerator.new(contract_schedules).rules
    Schedule::DateGenerator.new(start_date: start_date, end_date: end_date, date_rules: date_rules).dates
  end
end
