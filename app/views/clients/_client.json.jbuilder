json.extract! client, :id, :name, :phone, :address, :email, :created_at, :updated_at
json.url client_url(client, format: :json)
