class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_root

  def index
    #gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    
      render 'index', status: :unprocessable_entity
    end
  end

 #def new
 # @order = Order.new
  
 #end

  private

  
  #def order_params
    #params.require(:order).permit(:price, :post_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  #end

  def order_params
    params.require(:order).permit(:price, :post_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]#秘密
      Payjp::Charge.create(
        amount: order_params[:price],  # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'  
    )
  end

  def move_to_root
    redirect_to root_path unless current_user_can_access_order?
  end
  
  def current_user_can_access_order?
    
    @item.present? && @item.user != current_user && @item.order.nil?
  end
end
