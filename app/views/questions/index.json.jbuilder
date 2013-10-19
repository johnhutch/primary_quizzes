json.array!(@questions) do |question|
  json.extract! question, :body, :solution_id, :category_id, :user_id, :elo
  json.url question_url(question, format: :json)
end
