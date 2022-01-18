class Public::CustomersController < ApplicationController
    
  def show
        
    #admin側だった記述
    if @customer != current_customer
      @customer = Customer.find(params[:id])
      @real_estates = RealEstate.where(customer_id: @customer.id)
      # @real_estate = RealEstate.find(params[:id])
    else
      @customer = current_customer
    end
      #customerのcustomerの内、いいねされたものを絞り込
      @relationship = Relationship.new
      
      @favorites = Favorite.where(customer_id: @customer.id)
      
      @notifications = current_customer.passive_notifications.page(params[:page]).per(3)
      @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    
  end
    
    
    
    #  @customers = current_customer.matchers
  def new
    @customer =  Customer.new
  end
  
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customer_path(customer)
    else
      render 'new'
    end
  end
  
  def edit
    @customer = Customer.find(params[:id])
    if @customer
      render:edit
    else
      redirect_to public_customer_path(current_customer)
    end
  end
  
  def update
    @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
        redirect_to public_customer_path(@customer), notice: "You have updated customer successfully."
      else
       render "edit"
      end
  end
  
  private
  def customer_params
  params.require(:customer).permit(:email, :jobs,:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :tel, :jobs, :seriousness, :seriousness,:moving_date, :moving_schedule)
  end
end
