class TasksController < ApplicationController

  def index
    @tasks = Task.all.order(created_at: "DESC")
    if params[:sort_exprired]
      @tasks = Task.all.order(deadline_on: "DESC")
    end

    if params[:sort_priority]
      @tasks = Task.all.order(deadline_on: "ASC")
    end

    if params[:task].present?
      title_input = params[:task][:title]
      status_input = params[:task][:status]

      if title_input.present? && status_input.present?
        @tasks = Task.title_search(title_input).status_search(status_input)
      elsif title_input.present?
        @tasks = Task.title_search(title_input)
      elsif status_input.present?
        @tasks = Task.status_search(status_input)
      # if params[:task][:title].present? && params[:task][:status].present?
      #   @tasks = Task.where("title LIKE ?", "%#{params[:task][:title]}%").where(status: status)
      # elsif params[:task][:title].present?
      #   @tasks = Task.where("title LIKE ?", "%#{params[:task][:title]}%")
      # elsif params[:task][:status].present?
      #   @tasks = Task.where(status: status)
      end
    end
  end

  def search
    @tasks = Task.search(params[:keyword])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
    params.require(:task).permit(:title, :content, :status)
  end

end