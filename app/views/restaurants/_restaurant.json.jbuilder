json.extract! restaurant, :id, :name, :opens, :closes, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
