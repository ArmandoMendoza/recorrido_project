module SimpleAssignmentAlgorithmMethods

  #---- algorithm methods

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

  def assignment_process_for_week(week)
    company_specs = specs_for_week(week)
    users_specs = users_specs_for_week(week)
    results = Schedule::Algorithms::SimpleAssignmentAlgorithm.new(company_specs: company_specs, users_specs: users_specs).run
    
    company_schedules.update_all(user_id: nil)
    results.each do |result|
      company_schedules.find_by(block: result[:block])&.update_columns(user_id: result[:user_id])
    end
  end

end