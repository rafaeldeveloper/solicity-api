json.extract! category, :id, :name, :url_image, :created_at, :updated_at
json.url category_url(category, format: :json)