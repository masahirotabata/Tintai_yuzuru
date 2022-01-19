class Public::RealEstatesCommentController < ApplicationController
  def new
    @real_estates_comment = RealEstateComment.new
    @real_estate = RealEstate.find(params[:real_estate_id])
  end
  
  def create
    @real_estate = RealEstate.find(params[:real_estate_id])
    @real_estates_comment = RealEstateComment.new(real_estate_comment_params)
    @real_estates_comment.real_estate_id = @real_estate.id
    @real_estates_comment.customer_id = current_customer.id
      if @real_estates_comment.save
      redirect_to public_customer_path(current_customer)
      else
      render 'new'
      end
  end
  
  def index
    @real_estate_comments = RealEstateComment.all
  end
  def destroy
    @real_estate_comment = RealEstateComment.find_by(id: params[:id])
      if @real_estate_comment.destroy
        flash[:notice] = '投稿物件を解除しました'
        redirect_to public_customer_path(current_customer)
      else
      　flash[:notice] = '投稿物件を解除に失敗しました'
      end
  end
  
  
   private
    def real_estate_comment_params
      params.require(:real_estate_comment).permit(:real_estate_id, :customer_id, :rate, :comment)
    end
    
end