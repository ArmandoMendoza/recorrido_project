class ContractSchedule < ApplicationRecord

  ### Relations
  belongs_to :contract

  ### Validations
  validates_presence_of :day, :start_hour, :hours
end
