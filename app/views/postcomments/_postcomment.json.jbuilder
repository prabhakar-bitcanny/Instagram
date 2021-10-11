json.extract! postcomment, :id, :content, :user_id, :post_id, :created_at, :updated_at
json.url postcomment_url(postcomment, format: :json)
