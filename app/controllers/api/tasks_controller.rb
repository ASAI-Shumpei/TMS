# app/controllers/api/tasks_controller.rb
class Api::TasksController < ApplicationController
  def index
    @tasks = Task.order(Arel.sql("ABS(STRFTIME('%s', due_date) - STRFTIME('%s', 'now'))"))
    render json: @tasks
  end

  def show
    @task = Task.find(params[:id])
    render json: @task
  end
end