class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :table

  validate :restaurant_is_opened
  validate :time_dont_overlap

  PERIODS = [30, 60, 90]

  def period
    self.end - self.start
  end

  def period=(period)
    return if !PERIODS.include?(period)
    self.end = start+period
  end



  def time_dont_overlap
    errors.add(:base, "table is already booked") unless overlap?
  end

  def restaurant_is_opened
    restaurant = table.restaurant
    opened = restaurant.is_opened?(start) && restaurant.is_opened?(self.end)
    errors.add(:base, "restaurant is closed at this time") unless opened
  end

  def overlap?
    Reservation.where("table_id = ? AND end > ? AND start < ?", table_id, start, self.end).empty?
  end
end
