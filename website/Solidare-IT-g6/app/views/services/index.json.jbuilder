json.array!(@services) do |service|
  json.extract! service, :title, :description, :date_start, :date_end, :quick_match, :matching_service_id, :creator_id
  json.url service_url(service, format: :json)
end
