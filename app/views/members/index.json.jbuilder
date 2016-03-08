json.array!(@members) do |member|
  json.extract! member, :id, :user_id, :ligue_id, :status, :score, :scoreday
  json.url member_url(member, format: :json)
end
