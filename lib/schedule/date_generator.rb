module Schedule
  class DateGenerator

    attr_reader :start_date, :end_date, :date_rules, :dates

    def initialize(start_date:, end_date:, date_rules:)
      @start_date = start_date
      @end_date = end_date
      @date_rules = date_rules
      @dates = []
      run!
    end

    private

    def run!
      schedule = IceCube::Schedule.new(start_date)
      date_rules.each do |rule|
        schedule.add_recurrence_rule IceCube::Rule.weekly.day(rule.day).hour_of_day(rule.hour).minute_of_hour(rule.min)
      end
      schedule.occurrences(end_date).each do |occurrence|
        date = occurrence.to_date
        time = occurrence.to_time
        week = date.cweek
        day = date.cwday
        hour = time.hour
        block = "#{week}#{day}#{hour}".to_i
        @dates << { week: week, time: time, day: day, block: block }
      end
    end
  end
end