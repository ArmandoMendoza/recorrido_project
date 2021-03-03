module Schedule::Algorithms
  class OrToolAlgorithm

    attr_reader :company_specs, :users_specs, :results

    def initialize(company_specs:, users_specs:)
      @company_specs = company_specs
      @users_specs = users_specs
      @results = []
    end

    def run
      shifts = company_specs[:shifts]
      users = users_specs[:users]
    
      users_index = users_specs[:index]
      block_index = company_specs[:index]
    
      @scheduler = ORTools::BasicScheduler.new(people: users, shifts: shifts)
    
      scheduler.assignments.each do |assignment|
        results << { user_id: users_index[assignment[:person]], block: block_index[assignment[:shift]] }
      end

      results
    end

    def scheduler
      @scheduler ||= schedulers
    end

  end 
end