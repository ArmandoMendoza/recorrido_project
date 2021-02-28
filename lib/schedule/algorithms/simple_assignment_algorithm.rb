module Schedule::Algorithms
  class SimpleAssignmentAlgorithm

    attr_reader :company_specs, :users_specs, :results, :assigment

    def initialize(company_specs:, users_specs:)
      @company_specs = company_specs
      @users_specs = users_specs
      @results = []
      @assigment = {}
    end

    def run
      days = company_specs.keys
      days.each do |day|
        company_spec = company_specs[day]
        users_specs_ordered = users_specs[day].sort_by { |hsh| hsh[:offer]}.reverse
        users_specs_ordered.each do |user_spec|
          if user_spec[:offer] == company_spec[:demand]
            assign_user_to_block_batch(user_spec[:user_id], company_spec[:blocks])
            user_spec[:blocks] = []
            company_spec[:blocks] = []
          else
            assigned_blocks = []
            user_spec[:blocks].each do |block|
              if company_spec[:blocks].include?(block)
                assign_user_to_block(user_spec[:user_id], block)
                assigned_blocks << block
              end
            end
            user_spec[:blocks] = user_spec[:blocks] - assigned_blocks
            company_spec[:blocks] = company_spec[:blocks] - assigned_blocks
          end
        end 
      end
      results 
    end

    private

    def assign_user_to_block_batch(user_id, block_array)
      block_array.each { |block| assign_user_to_block(user_id, block) }
    end

    def assign_user_to_block(user_id, block)
      if assigment[user_id]
        assigment[user_id] += 1
      else
        assigment[user_id] = 1
      end
      @results << { user_id: user_id, block: block}
    end
  end 
end