class Role < ApplicationRecord
  has_many :time_slots
  has_many :users
end
