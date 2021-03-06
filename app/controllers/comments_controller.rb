class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_item, only: [:create]
  before_action :set_comment, only: [:update, :destroy]

  # GET /comments
  # GET /comments.json
  # def index
  #   @comments = Comment.all
  # end
  #
  # # GET /comments/1
  # # GET /comments/1.json
  # def show
  # end
  #
  # # GET /comments/new
  # def new
  #   @comment = Comment.new
  # end

  # GET /comments/1/edit
  # def edit
  # end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @item.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html {redirect_to item_path(@item), notice: 'Comment was successfully created.'}
        # format.json { render :show, status: :created, location: @comment }
      else
        format.html {redirect_to root_path, error: 'Failed to create comment'}
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html {redirect_to item_path(@item), notice: 'Comment was successfully updated.'}
        format.json {render :show, status: :ok, location: @comment}
      else
        format.html {render :edit}
        format.json {render json: @comment.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to item_path(@item), notice: 'Comment was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  def set_item
    if params[:type] == "BidItem"
      @item = BidItem.find(params[:bid_item_id])
    elsif params[:type] == "NonBidItem"
      @item = NonBidItem.find(params[:non_bid_item_id])
    else
      @item = Item.find(params[:item_id])
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
    unless @comment.nil?
      @item = @comment.item
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end
