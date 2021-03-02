module Schedule::Algorithms
  class SimpleAssignmentAlgorithm

    attr_reader :company_specs, :users_specs, :results, :counter_assigment

    def initialize(company_specs:, users_specs:)
      @company_specs = company_specs
      @users_specs = users_specs
      @results = []
      @counter_assigment = {}
    end

    def run

      reset_counter_assigment
      made_assigment

      reset_counter_assigment
      made_assigment

      results 
    end

    private

    def made_assigment
      total_users = user_ids.size
      return if total_users == 0

      days = company_specs.keys
      total_hours = company_specs.inject(0) { |n, (k,v)| n += v[:demand] }
      max_hour_week = total_hours/total_users


      days.each do |day|
        ## this return the user_ids array with more blocks availables. This is to rotate the users
        ids = calculate_user_availability.reject { |k, v| v == 0}.sort_by { |k, v| v }.to_h.keys
        company_spec = company_specs[day]

        ##OLD CODE, other way more simple to select the users.
        # users_specs_ordered = users_specs[day].sort_by { |hsh| hsh[:offer]}.reverse
        # users_specs_ordered.each do |user_spec|

        ids.each do |user_id|
          user_spec = select_user_spec_by(day: day, user_id: user_id)
          next if user_spec.nil? || counter_assigment[user_id].to_i >= max_hour_week
          assigned_blocks = []
          user_spec[:blocks].each do |block|
            if company_spec[:blocks].include?(block)
              assign_user_to_block(user_id, block)
              assigned_blocks << block
            end
            # break if counter_assigment[user_id].to_i >= max_hour_week ###OJO con esto
          end
          user_spec[:blocks] = user_spec[:blocks] - assigned_blocks
          company_spec[:blocks] = company_spec[:blocks] - assigned_blocks
        end
      end
    end

    def user_ids
      users = []
      users_specs.values.each do |users_array|
        users_array.each { |u| users << u[:user_id] } 
      end
      users.uniq
    end

    def select_user_spec_by(day:, user_id:)
      users_specs[day].select {|user_spec| user_spec[:user_id] == user_id }.first
    end

    def assign_user_to_block_batch(user_id, block_array)
      block_array.each { |block| assign_user_to_block(user_id, block) }
    end

    def reset_counter_assigment
      user_ids.each do |id|
        counter_assigment[id] = 0
      end
    end

    def calculate_user_availability
      hsh = {}
      users_specs.values.each do |array_spec|
        array_spec.each do |spec|
          if hsh[spec[:user_id]]
            hsh[spec[:user_id]] += spec[:blocks].size
          else
            hsh[spec[:user_id]] = spec[:blocks].size
          end
        end
      end
      hsh
    end

    def assign_user_to_block(user_id, block)
      if counter_assigment[user_id]
        counter_assigment[user_id] += 1
      else
        counter_assigment[user_id] = 1
      end
      @results << { user_id: user_id, block: block}
    end
  end 
end