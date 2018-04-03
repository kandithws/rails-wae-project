class BidInfosController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_bid_info, only: [:update, :destroy]
  before_action :set_item, only: [:create]

  # POST /bid_infos
  # POST /bid_infos.json
  def create
    @bid_info = BidInfo.new(bid_info_params)
    @bid_info.item = @item
    @bid_info.user = current_user
    @item.winning_bid = @bid_info
    if @bid_info.bid_price.nil?
      return redirect_to item_path(@item), flash: {error: 'Please enter some price'}
    end
    output = @item.validates_new_bid_price(@bid_info.bid_price)
    if output[:status]
      if @bid_info.save && @item.save
        respond_to do |format|
          format.html {redirect_to item_path(@item), notice: output[:msg]}
          format.json {render :show, status: :created, location: item_path(@item)}
        end
      else
        respond_to do |format|
          format.html {redirect_to item_path(@item), flash: {error: 'Unable to process entity'}}
          format.json {render json: @bid_info.errors, status: :unprocessable_entity}
        end
      end
    else
      respond_to do |format|
        format.html {redirect_to item_path(@item), flash: {error: output[:msg]}}
        format.json {render json: @bid_info.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /bid_infos/1
  # PATCH/PUT /bid_infos/1.json
  def update
    @item = @bid_info.item
    @bid_info.assign_attributes(bid_info_params)
    @item.winning_bid = @bid_info
    if @bid_info.bid_price.nil?
      # if not return it will go to the next line
      return redirect_to item_path(@item), flash: {error: 'Please enter some price'}
    end
    output = @item.validates_new_bid_price(@bid_info.bid_price)
    if output[:status]
      if @bid_info.save && @item.save
        respond_to do |format|
          format.html {redirect_to item_path(@item), notice: output[:msg]}
          format.json {render :show, status: :created, location: @item}
        end
      else
        puts @item.errors.full_messages
        respond_to do |format|
          format.html {redirect_to item_path(@item), flash: {error: 'Unable to process entity'}}
          format.json {render json: @bid_info.errors, status: :unprocessable_entity}
        end
      end
    else
      respond_to do |format|
        format.html {redirect_to item_path(@item), flash: {error: output[:msg]}}
        format.json {render json: @bid_info.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /bid_infos/1
  # DELETE /bid_infos/1.json
  def destroy
    @item = @bid_info.item
    del_id = @bid_info.id
    @bid_info.destroy
    if @item.winner_id == del_id
      # The bid_info that we are going to delete
      # is the current winning bid, so we need to update
      @item.update_winning_bid
      @item.save
    end

    respond_to do |format|
      format.html {redirect_to item_path(@item), notice: 'Bid was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_bid_info
    @bid_info = BidInfo.find(params[:id])
  end

  def set_item
    if params[:type] == "BidItem"
      @item = BidItem.find(params[:bid_item_id])
    elsif params[:type] == "NonBidItem"
      @item = NonBidItem.find(params[:non_bid_item_id])
    else
      @item = Item.find(params[:item_id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bid_info_params
    params.require(:bid_info).permit(:bid_price)
  end
end
