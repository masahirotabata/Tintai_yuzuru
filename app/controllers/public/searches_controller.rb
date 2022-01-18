class Public::SearchesController < ApplicationController

  def index
    @range = params[:range]
    #byebug
    #if @range == "Area"
    @real_estates = RealEstate.where(area_id: params[:range])
    #else
    #@books = RealEstate.looks(params[:search], params[:word])
    #end
  end

  private
  def search_for(model, content, method)
    # 選択したモデルがareaだったら
    if model == 'area'
      # 選択した検索方法がが完全一致だったら
      if method == 'perfect'
      Area.where(real_estate_erea: content)
      # 選択した検索方法がが部分一致だったら
      else
      Area.where('real_estate_erea LIKE ?', '%'+content+'%')
      end
    # 選択したモデルがpostだったら
    # elsif model == ''
    #   if method == 'perfect'
    #     Post.where(title: content)
    #   else
    #     Post.where('title LIKE ?', '%'+content+'%')
    #   end
    end
  end
end