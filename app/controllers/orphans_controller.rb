class OrphansController < ApplicationController

  def index
    @orphans = Todo.where(status: "Orphan")
    @lists = List.all
    @listdates = @lists.pluck(:date)
    @listdates.unshift('unassigned')
  end

  def update
    @todo = Todo.find(params[:todo_id])
    @list = List.find_by(date:todo_params[:status])
    @todo.list_id = @list.id
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to orphans_index_path, :gflash => { :success => "Task status successfully updated"} }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { redirect_to orphans_index_path, :gflash => { :warning => "Task not updated"} }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:status, :todo, :todo_id)
  end

end
