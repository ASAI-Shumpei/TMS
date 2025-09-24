require 'rails_helper'

RSpec.describe 'Api::Tasks', type: :request do
  let!(:task) { 
    Task.create!(subject: 'APIテスト', detail: 'JSON確認用', due_date: Time.zone.now + 1.day, status: :pending) 
  }

  describe 'GET /api/tasks/:id' do
    it '正しいタスクをJSON形式で返すこと' do
      get api_task_path(task), as: :json
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(task.id)
      expect(json_response['subject']).to eq('APIテスト')
      expect(response.content_type).to include('application/json')
    end
    
    it '存在しないタスクIDの場合、404 Not Foundを返すこと' do
      get "/api/tasks/999", as: :json
      expect(response).to have_http_status(:not_found)
    end
  end
end 