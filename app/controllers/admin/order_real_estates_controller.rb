class Admin::OrderRealEstatesController < ApplicationController
    
  def index
  @customers = Customer.all
  end

end
