class Comment2sController < ApplicationController
  before_action :set_comment2, only: [:show, :edit, :update, :destroy]

  # GET /comment2s
  # GET /comment2s.json
  def index
    @topic = Topic.find(params[:id])
    @comment2s = Comment2.all
  end

  # GET /comment2s/1
  # GET /comment2s/1.json
  def show
  end

  # GET /comment2s/new
  def new
    @comment2 = Comment2.new
  end

  # GET /comment2s/1/edit
  def edit
  end

  # POST /comment2s
  # POST /comment2s.json
  def create
    @comment2 = Comment2.new(comment2_params)

    respond_to do |format|
      if @comment2.save
        format.html { redirect_to @comment2, notice: 'Comment2 was successfully created.' }
        format.json { render :show, status: :created, location: @comment2 }
      else
        format.html { render :new }
        format.json { render json: @comment2.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comment2s/1
  # PATCH/PUT /comment2s/1.json
  def update
    respond_to do |format|
      if @comment2.update(comment2_params)
        format.html { redirect_to @comment2, notice: 'Comment2 was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment2 }
      else
        format.html { render :edit }
        format.json { render json: @comment2.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comment2s/1
  # DELETE /comment2s/1.json
  def destroy
    @comment2.destroy
    respond_to do |format|
      format.html { redirect_to comment2s_url, notice: 'Comment2 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment2
      @comment2 = Comment2.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment2_params
      params.require(:comment2).permit(:topic_id, :note)
    end
end
