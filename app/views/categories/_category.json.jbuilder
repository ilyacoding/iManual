json.extract! category, :id, :created_at, :updated_at
json.name translation_by_slug(category.slug, params[:locale])
json.url category_url(category, format: :json)
