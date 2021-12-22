class Public::CartRealEstatesController < ApplicationController
    before_action :move_to_signed_in


 def index
  @cart_real_estates = CartRealEstate.all
  @customer_cart_real_estates = CartRealEstate.where(customer_id: current_customer.id)
 end

 def create
  @cart_real_estate = CartRealEstate.new(cart_real_estate_params)
  @real_estate = @cart_real_estate.real_estate
 if @cart_real_estate.save
      redirect_to cart_real_estates_path,notice: "カートに商品が入りました"
 else
      redirect_to real_estate_path(@real_estate), notice: "商品の個数を指定してください"
 end
 end

 def update
  @cart_real_estate = CartRealEstate.find(params[:id])
  if @cart_real_estate.update(cart_real_estate_params)
    flash[:notice] = "商品の個数を変更しました"
    redirect_to request.referer
  else
    flash[:alert] = "商品個数の変更に失敗しました"
  end
 end

 def destroy
  @cart_real_estate = CartRealEstate.find(params[:id])
  if @cart_real_estate.destroy
    redirect_to request.referer, alert: "商品を削除しました"
  end
 end

 def destroy_all
  if CartRealEstate.destroy_all
    redirect_to request.referer, alert: "カート内を全て削除しました"
  end
 end

  def move_to_signed_in
    unless customer_signed_in?
      #サインインしていないユーザーはログインページが表示される
      redirect_to  '/customers/sign_in'
    end
  end

 private

 def cart_real_estate_params
   params.require(:cart_real_estate).permit(:customer_id, :real_estate_id, :pieces)
 end
end
