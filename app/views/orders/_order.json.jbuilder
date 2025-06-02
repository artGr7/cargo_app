json.extract! order, :id, :first_name, :last_name, :middle_name, :phone, :email, :weight, :length, :width, :height, :from, :to, :distance, :price, :created_at, :updated_at
json.url order_url(order, format: :json)
