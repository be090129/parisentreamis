json.array!(@bets) do |bet|
  json.extract! bet, :id, :start_at, :score1, :score2, :equipe1_id, :equipe2_id, :global_result_point, :result_point
  json.url bet_url(bet, format: :json)
end
