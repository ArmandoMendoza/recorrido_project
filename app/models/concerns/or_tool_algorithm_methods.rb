module OrToolAlgorithmMethods


  def users_specs_for_week(week)
    users = []
    users_index = {}
    available_users.each_with_index do |user, index|
      users_index[index] = user.id 
      hsh = { availability: [], max_hours: 168 }
      user.user_schedules.availables.by_week(week).each do |schedule|
        start_time = schedule.time.in_time_zone("Santiago")
        end_time = start_time + Schedule::DateRuleGenerator::BLOCK_DURATION.hour
        hsh[:availability] <<  { starts_at: start_time , ends_at: end_time } 
      end
      users << hsh
    end
    { users: users, index: users_index }
  end

  def specs_for_week(week)
    shifts = []
    block_index = {}
    company_schedules.by_week(week).each_with_index do |schedule, index|
      block_index[index] = schedule.block
      start_time = schedule.time.in_time_zone("Santiago")
      end_time = start_time + Schedule::DateRuleGenerator::BLOCK_DURATION.hour
      shifts <<  { starts_at: start_time , ends_at: end_time }
    end
    { shifts: shifts, index: block_index }
  end

  def assignment_process_for_week(week)
    company_specs = specs_for_week(week)
    users_specs = users_specs_for_week(week)
    
    results = Schedule::Algorithms::OrToolAlgorithm.new(company_specs: company_specs, users_specs: users_specs).run
    company_schedules.update_all(user_id: nil)

    results.each do |result|
      company_schedules.find_by(block: result[:block])&.update_columns(user_id: result[:user_id])
    end

  end


end