json.extract! task, :id, :subject, :detail, :due_date, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
