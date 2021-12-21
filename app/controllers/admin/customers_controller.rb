class Admin::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    if @customer != current_customer
    @real_estates = RealEstate.where(customer_id: @customer.id)
    @real_estate = RealEstate.find(params[:id])
    else
    @customer = current_customer
    end
  end
end
