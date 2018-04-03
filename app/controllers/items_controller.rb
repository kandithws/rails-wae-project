class ItemsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :set_current_category
  # GET /items
  # GET /items.json
  def index
    redirect_to root_path
    # we will not show it here
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item.view_count += 1

    if @item.is_bid_item? && @item.is_bidding_end? && !@item.close_deal
      @item.close_deal = true
    end
    @item.save
    @comments = Comment.where(item_id: @item).order("created_at ASC")
    @report = Report.new
    @report.reportable_id = @item.id
    @report.reportable_type = "Item"
    if @item.is_bid_item?
      @current_user_bid_info = @item.get_bid_info_by current_user
      if @item.bid_infos.size > 0
        if @item.sell_type
          @bid_infos = @item.bid_infos.order("bid_price DESC")
        else
          @bid_infos = @item.bid_infos.order("bid_price ASC")
        end
      end
    end
  end

  # GET /items/new
  def new
    @item = Item.new
    @item.type = params[:type]
    @item.images.build
    @item.bid_end_time = DateTime.now
  end

  # GET /items/1/edit
  def edit
    if @item.is_bidding_end?
      unless @item.close_deal
        @item.close_deal = true
        @item.save
      end
      return redirect_to item_path(@item), flash: {error: 'Bidding Has already End, Cannot edit any details anymore'}
    end
    if @item.close_deal
      return redirect_to item_path(@item), flash: {error: 'This Item deal has already been closed'}
    end

    @hide_bid_deadline = (@item.type == "NonBidItem")
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.user = current_user
    @item.view_count = 0
    @item.close_deal = false
    @item.sell_type = (params[:sell_type] == "Sell")
    @item.bid_end_time = convert_local_to_utc(params[:bid_end_time]) unless params[:bid_end_time].nil?
    respond_to do |format|
      if @item.save
        format.html {redirect_to root_path, notice: 'Item was successfully created.'}
        format.json {render :show, status: :created, location: @item}
      else
        format.html {render :new}
        format.json {render json: @item.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    if @item.is_bidding_end?
      unless @item.close_deal
        @item.close_deal = true
        @item.save
      end
      return redirect_to item_path(@item), flash: {error: 'Bidding Has already End, Cannot edit any details anymore'}
    end
    if @item.close_deal
      return redirect_to item_path(@item), flash: {error: 'This Item deal has already been closed'}
    end
    @item.assign_attributes(item_params)
    @item.sell_type = (params[:sell_type] == "Sell")
    @item.bid_end_time = convert_local_to_utc(params[:bid_end_time]) unless params[:bid_end_time].nil?
    respond_to do |format|
      # if @item.update(item_params)
      if @item.save
        format.html {redirect_to item_path(@item), notice: 'Item was successfully updated.'}
        format.json {render :show, status: :ok, location: @item}
      else
        format.html {render :edit}
        format.json {render json: @item.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html {redirect_to root_path, notice: 'Item was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def like
    @item.liked_by current_user

    if request.xhr?
      render json: { count: @item.likes.size, id: @item.id }
    else
      redirect_to item_path(@item)
    end
  end

  def unlike
    @item.unliked_by current_user

    if request.xhr?
      render json: { count: @item.likes.size, id: @item.id }
    else
      redirect_to item_path(@item)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_item
    if params[:id]
      @item = Item.find(params[:id])
    elsif params[:item_id]
      @item = Item.find(params[:item_id])
    end
  end

  def set_current_category
    @current_categories = Category.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    # http://api.rubyonrails.org/classes/ActiveRecord/Base.html#label-Single+table+inheritance
    if params[:type] == "BidItem"
      params.require(:bid_item).permit(:title, :body, :type,
                                       :category_id, :product_name,
                                       :product_desc, :product_ref_url, :close_deal,
                                       :product_price, images_attributes: [:content, :_destroy, :id])
    elsif params[:type] == "NonBidItem"
      params.require(:non_bid_item).permit(:title, :body, :type,
                                           :category_id, :product_name,
                                           :product_desc, :product_ref_url, :close_deal,
                                           :product_price, images_attributes: [:content, :_destroy, :id])
    else
      params.require(:item).permit(:title, :body, :type,
                                   :category_id, :product_name,
                                   :product_desc, :product_ref_url, :close_deal,
                                   :product_price, images_attributes: [:content, :_destroy, :id])
    end
  end

  def convert_local_to_utc(t_local)
    tmp = DateTime.strptime(t_local, '%m/%d/%Y %I:%M %p').to_formatted_s(:db)
    Time.parse(tmp).utc
  end

  def convert_utc_to_local(t_utc)
    t_utc.localtime
  end

end
