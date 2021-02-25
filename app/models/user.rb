class User < ApplicationRecord

  ### Relations
  belongs_to :company
  
  ### Validations
  validates_presence_of :name
end