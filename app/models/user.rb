class User < ApplicationRecord

  ### Relations
  belongs_to :company
  has_many :user_schedules
  
  ### Validations
  validates_presence_of :name

  ### Instance Methods

  def schedules_for_week(week)
    hsh = {}
    user_schedules.by_week(week).each do |schedule|
      date = schedule.time.in_time_zone("Santiago").strftime("%A %d of %B")
      data_hash = { id: schedule.id, hour: schedule.hour_block, block: schedule.block, available: schedule.available, color: color }
      if hsh[date]
        hsh[date] << data_hash
      else
        hsh[date] = [data_hash] 
      end
    end
    array = []
    hsh.each do |k, v|
      array << { date: k, values: v }
    end
    array
  end

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
    schedule.update!(available: true)
    schedule.available
  end

  def unset_availability!(block:)
    schedule = user_schedules.find_by!(block: block)
    schedule.update!(available: false)
    schedule.available
  end


end
