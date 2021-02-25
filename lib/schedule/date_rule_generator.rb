module Schedule
  class DateRuleGenerator

    attr_reader :rules, :contract_details

    def initialize(contract_details)
      @contract_details = contract_details
      @rules = []
      run!
    end

    private

    def run!
      contract_details.each do |cd|

        from_start_hour, min = cd.start_hour.split(":").map(&:to_i)

        to_end_hour = from_start_hour + cd.hours

        (from_start_hour..to_end_hour).each do |hour|
          @rules << OpenStruct.new(day: cd.day.to_sym, hour: hour, min: min)
        end
      end
    end
  end
end