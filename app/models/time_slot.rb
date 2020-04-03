class TimeSlot < ApplicationRecord
  belongs_to :role

  def current?
    time = Time.zone.now
    right_day_of_week = time.strftime("%A") == weekday

    if time.hour == start_hour
      starts_after_start_time = time.min > start_min
    else
      starts_after_start_time = time.hour > start_hour
    end

    if time.hour == end_hour
      ends_before_end_time = time.min < end_min
    else
      ends_before_end_time = time.hour < end_hour
    end

    right_day_of_week && starts_after_start_time && ends_before_end_time
  end
end
