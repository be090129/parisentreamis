json.array!(@ligues) do |ligue|
  json.extract! ligue, :id, :name, :owner_id
  json.url ligue_url(ligue, format: :json)
end
