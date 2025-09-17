# spec/models/task_spec.rb

require 'rails_helper'

RSpec.describe Task, type: :model do
  it '件名(subject)と詳細(detail)があれば有効であること' do
    task = Task.new(
      subject: 'RSpecの勉強を完了させる', 
      detail: 'モデルテストを理解する', 
      due_date: Time.current 
    )
    expect(task).to be_valid 
  end


  it '件名(subject)がなければ無効であり、かつsubjectにエラーが存在すること' do
    task = Task.new(subject: nil)
    
    expect(task).not_to be_valid 

    expect(task.errors[:subject]).to be_present 

    expect(task.errors.details[:subject].first[:error]).to eq(:blank)
  end
end