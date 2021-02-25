class Company < ApplicationRecord

  ### Relations
  has_one :contract
  has_many :users

  ### Validations
  validates_presence_of :name
end
