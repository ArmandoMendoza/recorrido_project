class Contract < ApplicationRecord

  ### Relations
  belongs_to :company
  has_many :contract_schedules

  ### Validations
  validates_presence_of :terms
end
