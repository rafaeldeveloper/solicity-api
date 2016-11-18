json.extract! request, :id, :user_id, :description, :professional_id, :created_at, :updated_at
json.url request_url(request, format: :json)