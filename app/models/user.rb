require "csv"

class User < ApplicationRecord
  belongs_to :role
  has_many :time_slots, through: :role
  validates :email, uniqueness: true
  validates :first_name, :last_name, :start_date, presence: true
  validates_format_of :email, :with => /(@gmail.com|@anyonecanlearntocode.com)/

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

  def self.create_all_from_csv(string_or_io)
    errors = []
    role_id = Role.find_by(name: "student").id
    csv = CSV.new(string_or_io)
    csv.each do |row|
      if row.length != 4
        errors << "Invalid row: #{row}"
        next
      end
      first_name = row[0].strip
      last_name = row[1].strip
      email = row[2].strip
      start_date = row[3].strip
      user = User.new(
        first_name: first_name,
        last_name: last_name,
        email: email,
        start_date: start_date,
        role_id: role_id,
      )
      unless user.save
        errors << "#{user.full_name}: #{user.errors.full_messages.join(", ")}"
      end
    end
    errors
  end
end
