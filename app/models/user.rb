class User < ApplicationRecord
  belongs_to :role
  has_many :time_slots, through: :role
  validates :email, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def valid_time?
    if is_admin?
      true
    elsif start_date < Time.now.getlocal
      puts "Valid start date, check for valid time slot..."
      time_slots.select { |time_slot| time_slot.current? }.any?
    end
  end

  def is_admin?
    role.name == "admin"
  end
end
