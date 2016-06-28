class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  include SessionsHelper
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.where(step_id: step_id)
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    step = Step.find_by(id: params[:step_id])
    @comment = Comment.new(step: step)
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @step = Step.find_by(id: params[:step_id])
    @comment = @step.comments.create(comment_params)

    respond_to do |format|
      if @comment.valid?
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :home_url }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to root_url }
        format.json { render :home_url, status: :ok, location: @comment }
      else
        format.html { render :home_url }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:name, :step_id)
    end
end