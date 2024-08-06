class OrdersController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)

    if @order_address.save
      # 成功時の処理
      #@order_address.valid?
      process_payment
      #@order_address.save
      redirect_to root_path
    else
      Rails.logger.info(@order_address.errors.full_messages) # エラーメッセージをログに出力
      render :index, status: :unprocessable_entity
    end
  end

  private

  def process_payment
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
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
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token).merge(user_id: current_user.id, item_id: params[:item_id])
  end #kakunin
end
