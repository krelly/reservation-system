class Restaurant < ApplicationRecord
  has_many :tables

  has_many :reservations, through: :tables
  def is_opened?(time)
    time.between?(opens, closes)
  end
end
