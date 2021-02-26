class CompanySchedule < ApplicationRecord

  ### Relations
  belongs_to :company
  belongs_to :user, optional: true

  ### Validations
  validates_presence_of :week, :day, :block, :time

end
