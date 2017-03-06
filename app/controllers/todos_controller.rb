class TodosController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.all
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
  end

  # GET /todos/1/edit
  def edit
  end


  # POST /todos
  # POST /todos.json
  def create
    @list = List.find(params[:list_id])
    @todo.list_id = params[:list_id]

    respond_to do |format|
      if @todo.save
        format.html { redirect_to list_path(params[:list_id]), :gflash => {:success => "Task successfully added"} }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new, :gflash => {:error => "Something went wrong"} }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to list_path(:id => params[:list_id]), :gflash => { :success => "Task status successfully updated"} }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:name, :desc, :status, :list_id, :new_list_date)
    end
end
