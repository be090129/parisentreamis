json.array!(@tournaments) do |tournament|
  json.extract! tournament, :id, :name, :start_date, :end_date, :private
  json.url tournament_url(tournament, format: :json)
end
