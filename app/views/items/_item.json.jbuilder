json.extract! item, :id, :title, :product_name, :product_price, :created_at, :updated_at
json.url item_url(item, format: :json)
