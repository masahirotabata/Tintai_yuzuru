class Public::SearchesController < ApplicationController
  

 def search
    # viewのform_tagにて
    # 選択したmodelの値を@modelに代入。
    @model = params["model"]
    # 選択した検索方法の値を@methodに代入。
    @method = params["method"]
    # 検索ワードを@contentに代入。
    @content = params["content"]
    # @model, @content, @methodを代入した、
    # search_forを@recordsに代入。
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    # 選択したモデルがcustomerだったら
    if model == 'area'
      # 選択した検索方法がが完全一致だったら
      if method == 'perfect'
        customer.where(real_estate_erea: content)
      # 選択した検索方法がが部分一致だったら
      else
        customer.where('real_estate_erea LIKE ?', '%'+content+'%')
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

