class Contract < ApplicationRecord

  ### Relations
  belongs_to :company
  has_many :contract_schedules

  ### Validations
  validates_presence_of :start_date, :end_date

  accepts_nested_attributes_for :contract_schedules

end
