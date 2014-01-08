json.array!(@projects) do |project|
  json.extract! project, :id, :creator_id, :validator_id, :title, :description
  json.url project_url(project, format: :json)
end
