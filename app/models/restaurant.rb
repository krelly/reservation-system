class Restaurant < ApplicationRecord
  has_many :tables
  has_many :reservations, through: :tables

  def opened_at?(at)
    # Compare only time, not dates
    opens_time = opens.utc.strftime('%H%M%S')
    closes_time = closes.utc.strftime('%H%M%S')
    time = at.utc.strftime('%H%M%S')

    if opens_time < closes_time
      # Normal time range (opens at 10:00 - closes at 23:00)
      opens_time <= time && time <= closes_time
    else
      # If it closes on other day (opens at 23:00 - closes at 2:00)
      !(closes_time <= time && time < opens_time)
    end
  end
end
