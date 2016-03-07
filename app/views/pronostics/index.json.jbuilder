json.array!(@pronostics) do |pronostic|
  json.extract! pronostic, :id, :user_id, :bet_id, :ligue_id, :score1, :score2
  json.url pronostic_url(pronostic, format: :json)
end
