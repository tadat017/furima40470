class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :ensure_not_seller, only: [:index, :create]#

  def index
    @order_address = OrderAddress.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def create
    @order_address = OrderAddress.new(order_address_params)

    if @order_address.save
      # 成功時の処理
      @order_address.valid?
      pay_item
      
      redirect_to root_path
    else
      Rails.logger.info(@order_address.errors.full_messages) # エラーメッセージをログに出力
      render :index, status: :unprocessable_entity
    end
  end

  private

  def  pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    token = order_address_params[:token]
    logger.debug "Received token: #{token}"
    Payjp::Charge.create(
      amount: @item.price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, 
      :prefecture_id,
      :city, 
      :addresses, 
      :building, 
      :phone_number
    ).merge(
      token: params[:token], 
      user_id: current_user.id, 
      item_id: params[:item_id]
    )
  end
  def ensure_not_seller#
    if @item.user_id == current_user.id
      redirect_to root_path, alert: "出品者は自分の商品を購入できません。"
    end
  end
