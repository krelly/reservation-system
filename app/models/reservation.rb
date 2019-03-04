class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :table


  PERIODS = [30, 60, 90]

  def period
    (end_time - start_time).to_i / 60
  end

  def period=(period)
    raise ArgumentError.new("period not in range") if !PERIODS.include?(period)
    write_attribute :end_time, start_time + period * 60
  end


  scope :overlapping, ->(table_id, start_time, end_time) do
    where("table_id = ? AND end_time > ? AND start_time < ?", table_id, start_time, end_time)
  end

  validate :restaurant_is_opened
  validate :not_reserved

  def not_reserved
    errors.add(:base, "table is already booked") if !overlap?
  end

  def restaurant_is_opened
    restaurant = table.restaurant
    opened = restaurant.opened_at?(start_time) && restaurant.opened_at?(end_time)
    errors.add(:base, "restaurant is closed at this time") unless opened
  end

  def overlap?
    Reservation.overlapping(table_id, start_time, end_time).where.not(id: id).empty?
  end


  private

  # Disallow assigning end_time directly
  # Should be used like:
  # Reservation.create!(user: User.last, table: Table.last, start_time: "2019-02-01 23:00:00", period: 30)

  def end_time=(val)
    write_attribute :end_time, val
  end
end
