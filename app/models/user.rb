class User < ApplicationRecord

  ### Relations
  belongs_to :company
  has_many :user_schedules
  
  ### Validations
  validates_presence_of :name

  ### Instance Methods

  def specs_by_day(week:, day:)
    schedules = user_schedules.by_week(week).by_day(day).availables
    
    if schedules.any?
      hsh = { user_id: id, day: day, blocks: [] }
      schedules.each do |schedule|
        hsh[:blocks] << schedule.block
      end

      hsh[:offer] = hsh[:blocks].size
      hsh
    end
  end

  def set_availability!(block:)
    schedule = user_schedules.find_by!(block: block)
    schedule.update_columns(available: true)
  end
end
