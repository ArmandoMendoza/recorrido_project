class CompanySchedule < ApplicationRecord

  ### Relations
  belongs_to :company
  belongs_to :user, optional: true

  ### Validations
  validates_presence_of :week, :day, :block, :time

  ### Scopes
  default_scope -> { order("time ASC") }
  scope :by_week, ->(w) { where(week: w) }
  scope :by_day,  ->(d) { where(day: d)  }
  scope :by_block,->(b) { where(block: b)  }

  def hour_block
    start_hour = time.strftime("%H:%M")
    end_hour = (time + Schedule::DateRuleGenerator::BLOCK_DURATION.hour).strftime("%H:%M")
    "#{start_hour} - #{end_hour}"
  end

end
