module Schedule
  class DateRuleGenerator

    attr_reader :rules, :contract_schedules

    def initialize(contract_schedules)
      @contract_schedules = contract_schedules
      @rules = []
      run!
    end

    private

    def run!
      contract_schedules.each do |cd|

        from_start_hour, min = cd.start_hour.split(":").map(&:to_i)

        to_end_hour = from_start_hour + cd.hours

        (from_start_hour..to_end_hour).each do |hour|
          @rules << OpenStruct.new(day: cd.day.to_sym, hour: hour, min: min)
        end
      end
    end
  end
end