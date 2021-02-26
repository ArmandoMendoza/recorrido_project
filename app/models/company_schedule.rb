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

end
