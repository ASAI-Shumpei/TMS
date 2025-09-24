require 'rails_helper'

RSpec.describe TasksController, type: :controller do  
  let(:valid_attributes) do
      { subject: '有効な件名', detail: '有効な詳細', due_date: Time.zone.now + 1.day, status: :pending }
  end

  describe 'DELETE #destroy' do
    let!(:task) { Task.create!(valid_attributes) }

    it 'タスクがデータベースから削除されること' do
      expect {
        delete :destroy, params: { id: task.to_param }
      }.to change(Task, :count).by(-1)
    end

    it 'タスク一覧へリダイレクトすること' do
      delete :destroy, params: { id: task.to_param }
      expect(response).to redirect_to(tasks_url)
    end
  end

  describe 'GET #show' do
    let!(:task) { Task.create!(valid_attributes) }

    it '正しいタスクを取得し、HTTP 200 OKを返すこと' do
      get :show, params: { id: task.to_param }
      expect(response).to have_http_status(:ok) 
      expect(assigns(:task)).to eq(task) 
      expect(response).to render_template(:show)
    end

    it '存在しないIDの場合、例外を発生させること' do
      expect {
        get :show, params: { id: 999 }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

  end

  describe 'GET #index' do

    let!(:task1) { 
      Task.create!(valid_attributes.merge(subject: '最新タスク', created_at: Time.zone.now)) 
    }
    let!(:task2) { 
      Task.create!(valid_attributes.merge(subject: '中間タスク', created_at: 1.day.ago)) 
    }
    let!(:task3) { 
      Task.create!(valid_attributes.merge(subject: '最古タスク', created_at: 2.days.ago)) 
    }

    it '全てのタスクを取得し、デフォルトの順序（新しい順）で表示すること' do
      get :index
      expect(assigns(:tasks)).to eq([task1, task2, task3]) 
      
      expect(response).to render_template(:index)
      expect(assigns(:tasks).count).to eq(3)
    end  

  end


  describe 'PATCH #update' do
  # テスト専用のタスクを事前に作成
  let!(:task) { Task.create!(valid_attributes) }
  
  # 更新後の有効な新しい属性
  let(:new_attributes) {
    { subject: '更新された件名', detail: '更新後の詳細', status: :completed }
  }

  it '有効なパラメーターでタスクを更新し、詳細ページにリダイレクトすること' do
    patch :update, params: { id: task.to_param, task: new_attributes }

    task.reload
    expect(task.subject).to eq('更新された件名')
    expect(task.status).to eq('completed')   

    expect(response).to redirect_to(task)
    expect(flash[:notice]).to be_present  
  end

  it '無効なパラメーターで更新を試みた場合、編集フォームが再表示されること' do

      invalid_attributes = { subject: '', detail: 'このデータは無効になるはず' }

      patch :update, params: { id: task.to_param, task: invalid_attributes }


      task.reload
      expect(task.subject).to eq('有効な件名') 
    
      expect(response).to have_http_status(:unprocessable_entity)
    
      expect(response).to render_template(:edit)
    end
  end


  describe 'POST #create' do 

    context '有効なパラメーターの場合' do
      it '新しいタスクがDBに追加されること' do

        expect {
          post :create, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it '作成後、タスクの詳細ページにリダイレクトすること' do
        post :create, params: { task: valid_attributes }
      
        expect(response).to redirect_to(Task.last)
        expect(flash[:notice]).to be_present 
      end
    end

    context '無効なパラメーターの場合' do
      let(:invalid_attributes) { valid_attributes.merge(subject: '') } 

      it 'タスクがDBに追加されないこと' do
        expect {
          post :create, params: { task: invalid_attributes }
        }.not_to change(Task, :count)
      end

      it 'ステータス422で新規登録ページを再表示すること' do
        post :create, params: { task: invalid_attributes }
      
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new) # newテンプレートに戻る
      end
    end
  end  
end

