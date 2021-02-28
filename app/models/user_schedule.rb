class UserSchedule < ApplicationRecord

  ### Relations
  belongs_to :company
  belongs_to :user

  ### Validations
  validates_presence_of :week, :day, :block, :time

  ### Scopes
  default_scope -> { order("time ASC") }
  scope :by_week,  ->(w) { where(week: w) }
  scope :by_day,   ->(d) { where(day: d)  }
  scope :by_block, ->(b) { where(block: b)  }
  scope :availables, -> { where(available: true) }
    
  def hour_block
    start_hour = time.in_time_zone("Santiago").strftime("%H:%M")
    end_hour = (time.in_time_zone("Santiago") + Schedule::DateRuleGenerator::BLOCK_DURATION.hour).strftime("%H:%M")
    "#{start_hour} - #{end_hour}"
  end

end
