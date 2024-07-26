class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品が正常に出品されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

   
  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :price,  :image).merge(user_id: current_user.id)
  end
end
