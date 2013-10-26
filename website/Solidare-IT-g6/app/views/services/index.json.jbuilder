json.array!(@services) do |service|
  json.extract! service, :description, :dateStart, :dateEnd
  json.url service_url(service, format: :json)
end
