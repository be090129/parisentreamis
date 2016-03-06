json.array!(@players) do |player|
  json.extract! player, :id, :name, :post, :point
  json.url player_url(player, format: :json)
end
