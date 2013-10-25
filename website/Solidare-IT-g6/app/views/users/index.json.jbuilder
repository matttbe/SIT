json.array!(@users) do |user|
  json.extract! user, :name, :firstname, :birthdate, :email, :karma, :id_ok, :presentation, :inscription_ok
  json.url user_url(user, format: :json)
end
