class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :ensure_not_seller, only: [:index, :create]
  before_action :ensure_not_sold, only: [:index, :create]


  def index
    @order_address = OrderAddress.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def create
    @order_address = OrderAddress.new(order_address_params)

    if @order_address.save
      
      pay_item
      redirect_to root_path
    else
      Rails.logger.info(@order_address.errors.full_messages)  
      render :index, status: :unprocessable_entity
    end
  end

  private

  def  pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    token = order_address_params[:token]
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
  def ensure_not_seller
    redirect_to root_path if @item.user_id == current_user.id
  end


  def ensure_not_sold
    redirect_to root_path if @item.order.present?
  end
end