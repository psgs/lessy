json.type 'task'
json.id task.id
json.attributes do
  json.extract! task, :label, :order, :planned_count, :state
  json.created_at task.started_at.to_i
  json.planned_at task.planned_at.to_i
  json.finished_at task.finished_at.to_i
  json.abandoned_at task.abandoned_at.to_i
end
json.relationships do
  json.user do
    json.data do
      json.type 'user'
      json.id task.user_id
    end
  end
  json.project do
    json.data do
      if task.project.nil?
        json.nil!
      else
        json.type 'project'
        json.id task.project_id
        json.attributes do
          json.name task.project.name
        end
      end
    end
  end
end
