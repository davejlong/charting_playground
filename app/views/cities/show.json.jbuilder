json.issues @issues do |issue|
  json.lat issue['lat']
  json.lng issue['lng']
  json.status issue['status']
  json.address issue['address']
  json.description issue['description']
end
