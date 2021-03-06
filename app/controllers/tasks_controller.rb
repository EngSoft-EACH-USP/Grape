class TasksController < ApplicationController
	def index
		if params[:task_filter].nil? or params[:task_filter].empty?
			@tasks = Task.all
		else
			@tasks = Task.all.select { |x| not x.category.nil? and x.category.start_with?(params[:task_filter]) }
		end
	end

	def new
		@task = Task.new
	end
	
	def create
		@task = Task.new(task_params)
		if @task.save
			redirect_to action: 'show', id: @task.id
		else
			render 'new'
		end
	end

	def show
		@task = Task.find(params[:id])
	end

	def delete
	end

	def destroy
		@task = Task.find(params[:id])
		@task.destroy
		redirect_to action: 'index'
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
  		@task.update(title: params[:task][:title], deadline: params[:task][:deadline], category: params[:task][:category])
  		redirect_to task_path(@task)
	end

	private
	def task_params
		params.require(:task).permit(:title, :deadline, :board_id, :category, :user_id )
	end
end
