class Public::AddressesController < ApplicationController
 def index
    @adress = Address.order("created_at DESC")
 end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def address_params
    params.require(:address).permit(:area,:text,:prefecture_id)
  end

end
