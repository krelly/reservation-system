json.extract! reservation, :id, :user_id, :table_id, :start, :end, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
