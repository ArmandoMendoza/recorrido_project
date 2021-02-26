class User < ApplicationRecord

  ### Relations
  belongs_to :company
  has_many :user_schedules
  
  ### Validations
  validates_presence_of :name
end
