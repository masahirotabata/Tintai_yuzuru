class Public::SearchesController < ApplicationController
  

  def index
    @range = params[:range]
    @real_estates = RealEstate.all

    if @range == "Customer"
     
      @customers = Customer.looks(params[:search], params[:word])
    else
      @real_estates = RealEstate.looks(params[:search], params[:word])
    end
  end
end

