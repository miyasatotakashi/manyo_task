class TasksController < ApplicationController
  before_action :check_user, only: %i[ show edit update destroy]

  def index
    @tasks = current_user.tasks.all.includes(:user).order(created_at: "DESC")
  if params[:sort_exprired] 
    @tasks = current_user.tasks.order(deadline_on: "DESC") 
  elsif params[:sort_priority]
    @tasks = current_user.tasks.order(priority: "ASC") 
  end
    if params[:task].present?
      title_input = params[:task][:title]
      status_input = params[:task][:status]
      label_input = params[:task][:label_id]

      if title_input.present? && status_input.present?
        @tasks = current_user.tasks.title_search(title_input).status_search(status_input)
      elsif title_input.present?
        @tasks = current_user.tasks.title_search(title_input)
      elsif status_input.present?
        @tasks = current_user.tasks.status_search(status_input)
      elsif label_input.present?
        @tasks = current_user.tasks.label_search(label_input)
      # if params[:task][:title].present? && params[:task][:status].present?
      #   @tasks = Task.where("title LIKE ?", "%#{params[:task][:title]}%").where(status: status)
      # elsif params[:task][:title].present?
      #   @tasks = Task.where("title LIKE ?", "%#{params[:task][:title]}%")
      # elsif params[:task][:status].present?
      #   @tasks = Task.where(status: status)
      end
    end
    @tasks = @tasks.page(params[:page]).per(5)
  end

  def search
    @tasks = Task.search(params[:keyword])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "投稿しました！"
      else
        render :new
      end
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:"削除しました！"
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :status, :priority, :deadline_on, label_ids:[])
  end

  def check_user
    @task = Task.find(params[:id])
    unless current_user.id == @task.user.id
      redirect_to tasks_path, notice: 'アクセスできません'
    end
  end
  
end