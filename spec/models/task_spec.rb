# spec/models/task_spec.rb

require 'rails_helper'

RSpec.describe Task, type: :model do

  let(:valid_attributes) do
    {
      subject: '有効な件名',
      detail: '有効な詳細',
      due_date: Time.zone.now + 1.day,
      status: :pending
    }
  end

  it '件名(subject)と詳細(detail)があれば有効であること' do
    task = Task.new(valid_attributes)
    expect(task).to be_valid 
  end

  it '件名(subject)がなければ無効であり、かつsubjectにエラーが存在すること' do
    task = Task.new(valid_attributes.merge(subject: nil))  
    expect(task).not_to be_valid 
    expect(task.errors[:subject]).to be_present 
    expect(task.errors.details[:subject].first[:error]).to eq(:blank)
  end

  it '詳細(detail)がなくても有効であること' do
    task = Task.new(valid_attributes.merge(detail: nil))
    expect(task).to be_valid           
  end

  it '詳細(detail)が300文字以内であれば有効であること' do 
    task = Task.new(valid_attributes.merge(detail: 'a' * 300))
    expect(task).to be_valid 
  end

  it '詳細(detail)が301文字（最大超過）なら無効であること' do 
    task = Task.new(valid_attributes.merge(detail: 'a' * 301))
    task.valid? 
    expect(task).not_to be_valid
    expect(task.errors[:detail]).to be_present
    expect(task.errors.details[:detail].first[:error]).to eq(:too_long)
  end

  it '期限(due_date)がなければ無効であること' do
    task = Task.new(valid_attributes.merge(due_date: nil))
    expect(task).not_to be_valid
    expect(task.errors[:due_date]).to be_present
    expect(task.errors.details[:due_date].first[:error]).to eq(:blank)
  end

  it '期限が過去の日付であればカスタムエラーで無効になること' do 
    past_time = Time.zone.now - 1.day
    task = Task.new(valid_attributes.merge(due_date: past_time))
    task.valid?
    expect(task).not_to be_valid
    expect(task.errors[:due_date]).to include("は過去に設定できません") 
  end

  it '期限が未来の日付であれば有効であること' do 
    future_time = Time.zone.now + 1.hour
    task = Task.new(valid_attributes.merge(due_date: future_time))
    expect(task).to be_valid
  end

  it 'ステータス(status)がなければ無効であること' do
    task = Task.new(valid_attributes.merge(status: nil)) 
    expect(task).not_to be_valid
    expect(task.errors[:status]).to be_present
    expect(task.errors.details[:status].first[:error]).to eq(:blank)
  end

  it 'enumで定義されていない不正なステータス値は無効であること' do
    task = Task.new(valid_attributes)
    expect { 
      task.status = 99 
    }.to raise_error(ArgumentError)
  end

end