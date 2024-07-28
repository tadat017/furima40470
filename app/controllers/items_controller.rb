class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit ]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
    if current_user.id != @item.user_id
      redirect_to root_path
    end
  end

 def update
  @item = Item.find(params[:id])
  if current_user.id != @item.user_id
    redirect_to root_path
  elsif @item.update(item_params)
    redirect_to item_path(@item)
   else
    render :edit,status: :unprocessable_entity
   end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品が正常に出品されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end
     
  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :price,  :image).merge(user_id: current_user.id)
  end
end
