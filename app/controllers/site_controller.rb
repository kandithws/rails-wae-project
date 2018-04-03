class SiteController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def home
  end

  def show
    if params[:name]
      @category = Category.where(:name => params[:name]).first
      @items = @category.items unless @category.nil?
      @non_bid_count = 1
    else
      flash[:error] = 'Category Error !'
      redirect_to root_path
    end
  end

  def main
    @non_bid_items = NonBidItem.all.order("created_at DESC")
    @non_bid_count = 1
    @bid_items = BidItem.all.order("created_at DESC")
    @bid_count = 1
    @categories=Category.all.group_by {|c| c.name}
  end

  def search
    if params[:search].blank?
      flash[:notice] = 'Enter Product name!!'
      redirect_to root_path
    else
      @q=params[:search].downcase


      @p_count=1
      @posts = Item.where('lower(product_name) LIKE ? OR cast(product_price as text) >   ?', "%#{@q}%","%#{@q}%") 

    end
  end

end

# <% @categories.each do |c, v| %>
#  <li><%= link_to c, show_path(:name => c) %></li>
# <% end %>
